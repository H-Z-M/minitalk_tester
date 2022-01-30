#!/bin/bash

make -C ..> /dev/null
cp ../server ../client .
clang++ time.cpp -o time > /dev/null
gcc unicode.c -o uni > /dev/null
tmux kill-pane -t 1 > /dev/null 2>&1
tmux split-window -h
tmux send-keys -t 1 './server' C-m
tmux select-pane -t 0
sleep 2
pid=`ps | grep -v grep | grep ./server | awk '{print $1}'`
testcount=3

ft_other()
{
	echo "file/Arabic.txt"
	./time $pid "file/Arabic.txt"
	echo "file/Turkish.txt"
	./time $pid "file/Turkish.txt"
	echo "file/Persian.txt"
	./time $pid "file/Persian.txt"
	# unicode test
	./client $pid `./uni 1 | iconv -f UTF-8 -t UTF-8`
	./client $pid `./uni 2 | iconv -f UTF-16LE -t UTF-8`
	./client $pid `./uni 3 | iconv -f UTF-32LE -t UTF-8`
}

ft_seq()
{
	for i in `seq 1 10`; do
		./client $pid $(printf %0100d $i)
		echo -n "$i,"
	done
	echo "Done"
	./client $pid "____END"
	return
}

ft_test()
{
	echo "file:1"
	for i in `seq 1 $testcount`
	do
		./time $pid "file/1.txt"
	done
	echo "file:10"
	for i in `seq 1 $testcount`
	do
		./time $pid "file/10.txt"
	done
	echo "file:100"
	for i in `seq 1 $testcount`
	do
		./time $pid "file/100.txt"
	done
	echo "file:1000"
	for i in `seq 1 $testcount`
	do
		./time $pid "file/1000.txt"
	done
	echo "file:10000"
	for i in `seq 1 $testcount`
	do
		./time $pid "file/10000.txt"
	done
	echo "file:100000"
	for i in `seq 1 $testcount`
	do
		./time $pid "file/100000.txt"
	done
	echo "file:200000"
	for i in `seq 1 $testcount`
	do
		./time $pid "file/200000.txt"
	done
	./client $pid "___END___"
}

foo()
{
	seq 2 | xargs -P 2 -I{} ./client $pid aaoobbwww
	seq 5 | xargs -P 5 -I{} bash "test.sh"
	./client -1 $(printf %01000d 1)
	./client 0 $(printf %01000d 1)
	./client 1 $(printf %01000d 1)
	./client 2 $(printf %01000d 1)
	./client 3 $(printf %01000d 1)
	./client 4 $(printf %01000d 1)
	./client 5 $(printf %01000d 1)
	./client 6 $(printf %01000d 1)

	./client $pid "a"
	./client $pid "pane0:#######################&&&&&&&&&&&&&&&&&&&)_-_-_-"
	./client $pid pane1:asdfgjjjjjkklwwwwwwwwwwwwwwwwwwweeeeeeeeeeeeeeeeerrrrrrrrrrrrrrruuuuuuuuuuuuiiiiiiioooooooooaaassssssdddddffffffffvv_-_-_-
	./client $pid "pane1:ASDFASDFASDFADSFASDFADSFASDFADSFADFAASDF_-_-_-"
	./client $pid "pane0:#######################&&&&&&&&&&&&&&&&&&&)_-_-_-"
	./client $pid 1:いいいいいいいいいいいいいいいいいいい:1_-_-_-
	./client $pid 2:あああああああああああああああああああ:2_-_-_-
	tmux send-keys -t 0 './client '$pid' pane1:asdfgjjjjjkklwwwwwwwwwwwwwwwwwwweeeeeeeeeeeeeeeeerrrrrrrrrrrrrrruuuuuuuuuuuuiiiiiiioooooooooaaassssssdddddffffffffvv' C-m
}

# ft_test
# ft_seq
ft_other
echo -n "Delete the pane1? [y/n] "
read str
case "$str" in
	[Yy]|[Yy][Ee][Ss])
		tmux kill-pane -t 1
		;;
	[Nn]|[Nn][Oo])
		;;
	*)
		echo "undefined";;
esac
rm time client server uni
