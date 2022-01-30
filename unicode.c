#include <unistd.h>

int    main(int argc, char **argv)
{
	if (argv[1][0] == '1')
		write(1, "\xE3\x81\x82", 3); // UTF-8エンコードされた「あ」を出力
	else if (argv[1][0] == '2')
		write(1, "\x42\x30", 2); // UTF-16LEエンコードされた「あ」を出力
	else if (argv[1][0] == '3')
		write(1, "\x42\x30\x00\x00", 4); // UTF-32LEエンコードされた「あ」を出力
	return (0);
}
