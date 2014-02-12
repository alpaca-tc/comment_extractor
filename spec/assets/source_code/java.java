//[-1-]Attribution-Share Alike 3.0 License, copyright (c) 2010 Pieter Hintjens, modified @alpaca-tc
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.atomic.AtomicLong;

import org.zeromq.ZContext;
import org.zeromq.ZMQ;
import org.zeromq.ZMQ.Socket;
/*[-9-]
[-10-]Clone client model 1
[-11-]@author Danish Shrestha <dshrestha06@gmail.com>
[-12-]aa
[-13-] [-end-]*/
public class clonecli1 {
  private static Map<String, kvsimple> kvMap = new HashMap<String, kvsimple>();
  private static AtomicLong sequence = new AtomicLong();

  public void run() { //[-18-]
    ZContext ctx = new ZContext();
    Socket subscriber = ctx.createSocket(ZMQ.SUB);
    subscriber.connect("tcp://localhost:5556");
    subscriber.subscribe("".getBytes());
    /*[-23-] [-end-]*/
    while (true) {
      kvsimple kvMsg = kvsimple.recv(subscriber);
            if (kvMsg == null)
                break;

            clonecli1.kvMap.put(kvMsg.getKey(), kvMsg);
            System.out.println("receiving " + kvMsg);
            sequence.incrementAndGet();
    }
        ctx.destroy();
  }

  public static void main(String[] args) {
    new clonecli1().run();
  }
}
