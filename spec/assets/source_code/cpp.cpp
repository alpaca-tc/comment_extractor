#include "zhelpers.hpp"
#include <queue>
//[-3-]Attribution-Share Alike 3.0 License, copyright (c) 2010 Pieter Hintjens, modified @alpaca-tc
//[-4-]Basic request-reply client using REQ socket
static void *
client_thread (void *arg) {
  zmq::context_t context(1);
    zmq::socket_t client (context, ZMQ_REQ);
    s_set_id (client);      //[-9-]Makes tracing easier
    client.connect("ipc://frontend.ipc");

    //[-12-]  Send request, get reply
    s_send (client, "HELLO");
    std::string reply = s_recv (client);
    /*[-15-]  Send request, get reply [-end-]*/
    return (NULL);
}

static void *
worker_thread (void *arg) {
  zmq::context_t context(1);
    zmq::socket_t worker (context, ZMQ_REQ);
    s_set_id (worker);
    worker.connect("ipc://backend.ipc");

    s_send (worker, "READY");

    while (1) {
        /*[-29-]
[-30-]Read and save all frames until we get an empty frame
[-31-]In this example there is only 1 but it could be more [-end-]*/
        std::string address = s_recv (worker);
        {
            std::string empty = s_recv (worker);
            assert (empty.size() == 0);
        }

        std::string request = s_recv (worker);
        std::cout << "Worker: " << request << std::endl;

        s_sendmore (worker, address);
        s_sendmore (worker, "");
        s_send     (worker, "OK");
    }
    return (NULL);
}

int main (int argc, char *argv[])
{

    zmq::context_t context(1);
    zmq::socket_t frontend (context, ZMQ_ROUTER);
    zmq::socket_t backend (context, ZMQ_ROUTER);
    frontend.bind("ipc://frontend.ipc");
    backend.bind("ipc://backend.ipc");

    int client_nbr;
    for (client_nbr = 0; client_nbr < 10; client_nbr++) {
        pthread_t client;
        pthread_create (&client, NULL, client_thread, NULL);
    }
    int worker_nbr;
    for (worker_nbr = 0; worker_nbr < 3; worker_nbr++) {
        pthread_t worker;
        pthread_create (&worker, NULL, worker_thread, NULL);
    }
    std::queue<std::string> worker_queue;

    while (1) {

        zmq::pollitem_t items [] = {
            { backend,  0, ZMQ_POLLIN, 0 },
            { frontend, 0, ZMQ_POLLIN, 0 }
        };
        if (worker_queue.size())
            zmq::poll (&items [0], 2, -1);
        else
            zmq::poll (&items [0], 1, -1);

        if (items [0].revents & ZMQ_POLLIN) {

            worker_queue.push(s_recv (backend));

            {
               std::string empty = s_recv (backend);
               assert (empty.size() == 0);
            }

            std::string client_addr = s_recv (backend);

            if (client_addr.compare("READY") != 0) {

                {
                    std::string empty = s_recv (backend);
                    assert (empty.size() == 0);
                }

                std::string reply = s_recv (backend);
                s_sendmore (frontend, client_addr);
                s_sendmore (frontend, "");
                s_send     (frontend, reply);

                if (--client_nbr == 0)
                    break;
            }
        }
        if (items [1].revents & ZMQ_POLLIN) {

            std::string client_addr = s_recv (frontend);

            {
                std::string empty = s_recv (frontend);
                assert (empty.size() == 0);
            }

            std::string request = s_recv (frontend);

            std::string worker_addr = worker_queue.front();
            worker_queue.pop();

            s_sendmore (backend, worker_addr);
            s_sendmore (backend, "");
            s_sendmore (backend, client_addr);
            s_sendmore (backend, "");
            s_send     (backend, request);
        }
    }
    sleep (1);
    return 0;
}
