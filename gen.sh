#!/bin/sh

MAX_X=$2

if [ "$2" == "" ]; then
	MAX_X=65
fi

CUTOFF=$(($1 / 100))
echo $CUTOFF

echo out: $1
rm data_$1.pdf 2>/dev/null
gnuplot <<EOF
set term pdf enhanced
set output "data_$1.pdf"
set xlabel "Number of Threads"
set ylabel "Milliseconds to Completion"
set key left
set title "Queue Capacity $1"
set xrange [2:$MAX_X]

set xtics add ("Cutoff" $CUTOFF)

#plot "data/lock_$1" using 1:(\$3/\$1), "data/wf_$1" using 1:(\$3/\$1)
plot "data/lock_$1" using 1:2:3 title "Locked Queue" w err, "data/wf_$1" using 1:2:3 title "MPSCQ" w err
EOF

