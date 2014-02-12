//[-1-]Attribution-Share Alike 3.0 License, copyright (c) 2010 Pieter Hintjens, modified @alpaca-tc
//[-2-] Task Wroker
//[-3-] Connects PULL socket to tcp://localhost:5557
//[-4-] Collects workloads from ventilator via that socket
//[-5-] Connects PUSH socket to tcp://localhost:5558
//[-6-] Connects SUB socket to tcp://localhost:5559
//[-7-] Sends results to sink via that socket
//[-8-]
package main

import (
  "fmt"
  zmq "github.com/alecthomas/gozmq"
  "strconv"
  "time"
)

func main() {
  context, _ := zmq.NewContext()
  defer context.Close()

  /*[-22-]
[-23-]  Socket to receive messages on
*/
  receiver.Connect("tcp://localhost:5557")

  //[-27-]  Socket to send messages to task sink
  sender, _ := context.NewSocket(zmq.PUSH)
  defer sender.Close()
  sender.Connect("tcp://localhost:5558")

  //[-32-]  Socket for control input
  controller, _ := context.NewSocket(zmq.SUB)
  defer controller.Close()
  controller.Connect("tcp://localhost:5559")
  controller.SetSubscribe("")

  items := zmq.PollItems{
    zmq.PollItem{Socket: receiver, Events: zmq.POLLIN},
    zmq.PollItem{Socket: controller, Events: zmq.POLLIN},
  }

  //[-43-]  Process tasks forever
  for {
    zmq.Poll(items, -1)
    switch {
    case items[0].REvents&zmq.POLLIN != 0: /*[-47-]  Process tasks forever [-end-]*/
      msgbytes, _ := receiver.Recv(0)
      fmt.Printf("%s.", string(msgbytes))

      //[-51-]  Do the work
      msec, _ := strconv.ParseInt(string(msgbytes), 10, 64)
      time.Sleep(time.Duration(msec) * 1e6)

      sender.Send([]byte(""), 0) //[-55-]  Send results to sink
    case items[1].REvents&zmq.POLLIN != 0:
      fmt.Println("stopping")
      return
    }
  }
}
