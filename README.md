# mw -- Moscow Weather

Create your `config.sh` with `APIKEY=xxx` and run `make install`.

It will install the four files into `~/bin`:
- `mw`, the main program
- `mwstat` to create and display the graph
- `config.sh` to keep your `APIKEY` value
- `xcolor` tool to handle colorized console output

It will create two cache files in `/var/tmp/*.mw` and
- `~/.mw/history`
- `~/.mw/errors`
- `~/.mw/graph.svg`

The `mw` will use `curl` to fetch data.  
The `xcolor` needs `tput`.  
The grapher (`mwstat`) requires **GNU plot** utils (`graph`) and `eog` to work.

Create a terminal and run `watch --interval=10 ~/bin/mw` to see the weather...

# EOF #
