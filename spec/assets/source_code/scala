/*[-1-]Attribution-Share Alike 3.0 License, copyright (c) 2010 Pieter Hintjens, modified @alpaca-tc
[-2-]Asynchronous client-to-server (DEALER to BROKER)
[-3-]
[-4-]While this example runs in a single process, that is just to make
[-5-]it easier to start and stop the example. Each task has its own
[-6-]context and conceptually acts as a separate process.
[-7-]
[-8-]@Author:     Giovanni Ruggiero
[-9-]@Email:      giovanni.ruggiero@gmail.com
*/

import org.zeromq.ZMQ
import ZHelpers._

object asyncsrv  {
 //[-16-]  ---------------------------------------------------------------------
 //[-17-]  This is our client task
 //[-18-]  It connects to the server, and then sends a request once per second
 //[-19-]  It collects responses as they arrive, and it prints them out. We will
 //[-20-]  run several client tasks in parallel, each with a different random ID.
 class ClientTask() extends Runnable {
   def run() {
     val ctx = ZMQ.context(1)
     val client = ctx.socket(ZMQ.DEALER)
     setID(client);
     val identity = new String(client getIdentity)
     client.connect("tcp://localhost:5570")
     val poller = ctx.poller(1)

     poller.register(client,ZMQ.Poller.POLLIN)
     var requestNbr = 0
     while (true) { //[-32-]  Tick once per second, pulling in arriving messages
       for (centitick <- 1 to 100) {
         poller.poll(10000)
         if(poller.pollin(0)) {
           val msg = new ZMsg(client)
           printf("%s : %s\n", identity, msg.bodyToString)
         }
       }
       requestNbr += 1
       val msg = new ZMsg("request: %d" format requestNbr)
       client.sendMsg(msg)
     }
   }
 }
}
