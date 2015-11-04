#!/bin/bash
#                                      _
#         ___ _ __   ___ _ __ ___   __| |
#        / __| '_ \ / __| '_ ` _ \ / _` |
#        \__ | |_) | (__| | | | | | (_| |
#        |___| .__/ \___|_| |_| |_|\__,_|
#             |_|
#
#                    tra.sh
#               Created by: spcmd
#           http://spcmd.github.io
#           https://github.com/spcmd
#           https://gist.github.com/spcmd


trash_dir=$HOME/.local/share/Trash
size=$(du -hs $trash_dir | awk '{ print $1; }')
count=$(find $trash_dir -type f \( ! -iname "*.trashinfo" ! -iname "metadata" \) | wc -l)

cat << EOF

            )>)))))))))))))=            
            ))\           ))=           
     /))))))))))))))))))))))))))))>     
    ())))))))))))))))))))))))))))))>    
      )))=  ===   .===   ====  )))             tra.sh
      )))= .)))   ())>   )))>  )))          =============
      )))= .)))   ())>   )))>  )))          files: $count
      )))= .)))   ())>   )))>  )))          size:  $size
      )))= .)))   ())>   )))>  )))
      )))= .)))   ())>   )))>  )))
      )))= .)))   ())>   )))>  )))
      )))= .)))   ())>   )))>  )))
      )))= .)))   ())>   )))>  )))
      )))= .)))   ())>   )))>  )))
      ())> ((()   ((()   (((\ ))))
       \))))))))))))))))))))))))>

EOF