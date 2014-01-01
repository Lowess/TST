#!/bin/sh

\rm in* out*

# Create named pipes, one input and one output per process.
mkfifo in1 out1
mkfifo in2 out2
mkfifo in3 out3
mkfifo in4 out4
mkfifo in5 out5
mkfifo in6 out6
mkfifo in7 out7

mkfifo in1a out1a
mkfifo in3a out3a
mkfifo in5a out5a
 
# Starting the processes
./rou.tk --ident=node1 --debug < in1 > out1 &
./rou.tk --ident=node2 < in2 > out2 &
./rou.tk --ident=node3 --debug < in3 > out3 &
./rou.tk --ident=node4 < in4 > out4 &
./rou.tk --ident=node5 --debug < in5 > out5 &
./rou.tk --ident=node6 < in6 > out6 &
./rou.tk --ident=node7 < in7 > out7 &

./tst.tk --ident=node1 --debug < in1a > out1a &
./tst.tk --ident=node5 --debug < in5a > out5a &
./tst.tk --ident=node3 --debug < in3a > out3a &
 
# Waiting for the link creation (security delay)
sleep 1 
 
# Links creation: output -> input
# 1 -> 2 and 3
cat out1 | tee in2 in3 in1a &
# 2 -> 1, 4 and 5
#~ cat out2 | tee in1 in4 in5 &
#~ # 3 -> 1 and 6
#~ cat out3 | tee in1 in6 &
#~ # 4 -> 2, 5 and 7
#~ cat out4 | tee in2 in5 in7 &
#~ # 5 -> 2 and 4
#~ cat out5 | tee in2 in4 &
# 6 -> 3 and 7
cat out6 | tee in3 in7 &
# 7 -> 4 and 6
cat out7 | tee in4 in6 &
 
# Waiting 10 seconds before changing the topology
#~ sleep 10
 
# Deleting link 5 <-> 2
# Deleting link 5 <-> 4
# Adding link 5 <-> 3
#~ num=`ps aux | grep "cat out2" | grep -v grep | tr -s ' ' | cut -d' ' -f2`
#~ kill -KILL $num
 #~ 
#~ num=`ps aux | grep "cat out3" | grep -v grep | tr -s ' ' | cut -d' ' -f2`
#~ kill -KILL $num 
 #~ 
#~ num=`ps aux | grep "cat out4" | grep -v grep | tr -s ' ' | cut -d' ' -f2`
#~ kill -KILL $num 
 #~ 
#~ num=`ps aux | grep "cat out5" | grep -v grep | tr -s ' ' | cut -d' ' -f2`
#~ kill -KILL $num 
 
# Creating new connections and recreating those that would not have been deleted.
cat out2 | tee in1 in4 &
cat out3 | tee in1 in5 in6 in3a &
cat out4 | tee in2 in7 &
cat out5 | tee in3 in5a &

cat out1a > in1 &
cat out5a > in5 &
cat out3a > in3 &

