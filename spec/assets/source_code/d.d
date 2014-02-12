/*[-1-]@copyright wikipedia http://en.wikibooks.org/wiki/D_Programming/First_Program_Examples [-end-]*/
/*[-2-]Hello World in D
[-3-]To compile:
[-4-]dmd hello.d
[-5-]or to optimize:
[-6-]dmd -O -inline -release hello.d
[-7-]or to get generated documentation:
[-8-]dmd hello.d -D
*/
import std.stdio;  //[-10-]References to  commonly used I/O routines.
void main(char[][] args)
{
  //[-13-]Write-Formatted-Line
  writefln("Hello World, "
      "Reloaded");
  foreach(argc, argv; args)
  {
    auto cl = new CmdLin(argc, argv);

    writefln(cl.argnum, cl.suffix, " arg: //%s", cl.argv);
    delete cl;
  }
  struct specs
  {
    int count, allocated;
  }

  specs argspecs(char[][] args)
    in{
      assert (args.length > 0);
    }
  out(result){
    assert(result.count == CmdLin.total);
    assert(result.allocated > 0);
  }
  body{
    specs* s = new specs;
    s.count = args.length;  //[-38-] The 'length' property is number of elements.
    s.allocated = typeof(args).sizeof;
    foreach(argv; args)
      s.allocated += argv.length * typeof(argv[0]).sizeof;
    return *s;
  }

  char[] argcmsg  = "argc = %d";
  char[] allocmsg = "allocated = %d";
  writefln(argcmsg ~ ", " ~ allocmsg,
      argspecs(args).count,argspecs(args).allocated);
}
/*[-50-]
[-51-]Stores a single command line argument.
[-52-][-end-]*/
class CmdLin
{
  private {
    int _argc;
    char[] _argv;
    static uint _totalc;
  }

  public:
  this(int argc, char[] argv)
  {
    _argc = argc + 1;
    _argv = argv;
    _totalc++;
  }

  ~this()
  {
  }

  int argnum()
  {
    return _argc;
  }
  char[] argv()
  {
    return _argv;
  }
  wchar[] suffix()
  {
    wchar[] suffix;
    switch(_argc)
    {
      case 1:
        suffix = "st";
        break;
      case 2:
        suffix = "nd";
        break;
      case 3:
        suffix = "rd";
        break;
      default:
        suffix = "th";
    }
    return suffix;
  }

  static typeof(_totalc) total()
  {
    return _totalc;
  }
  invariant
  {
    assert(_argc > 0);
    assert(_totalc >= _argc);
  }
}
