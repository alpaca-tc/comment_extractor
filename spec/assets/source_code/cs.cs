//[-1-]Attribution-Share Alike 3.0 License, copyright (c) 2010 Pieter Hintjens, modified @alpaca-tc
//[-2-]  Author:     Yan Cui
//[-3-]  Email:      theburningmonk@gmail.com

using System;
using System.Collections.Generic;
using System.Threading;
using ZeroMQ;

namespace zguide.clonesrv1
{
    internal class Program
    {
        public static void Main(string[] args)
        {
            using (var context = ZmqContext.Create())
            {
                using (var publisher = context.CreateSocket(SocketType.PUB))
                {
                    publisher.Bind("tcp://*:5556");
                    Thread.Sleep(TimeSpan.FromMilliseconds(200));

                    var interrupted = false; //[-23-] single line
                    var sequence = 0L;/*[-24-] multi line [-end-]*/
                    var random = new Random((int)DateTime.UtcNow.Ticks);
                    var dict = new Dictionary<string, KvMsg>();
                    /*[-27-]
[-28-] multi line [-end-]
*/
                    Console.CancelKeyPress += (s, e) => { interrupted = true; };

                    while (!interrupted)
                    {
                        sequence++;
                        var kvmsg = new KvMsg(sequence);
                        kvmsg.Key = random.Next(1, 10000).ToString();
                        kvmsg.Body = random.Next(1, 1000000).ToString();

                        kvmsg.Send(publisher);
                        kvmsg.Store(dict);

                        Console.WriteLine("Published {0}", kvmsg);

                        Thread.Sleep(TimeSpan.FromMilliseconds(100));
                    }

                    Console.WriteLine(" Interrupted\n{0} messages out\n", sequence);
                    Console.ReadKey();
                }
            }
        }
    }
}
