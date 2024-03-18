#!/bin/bash

cd $1
echo "#!/bin/bash
# $2
exit $3
" > script.sh

