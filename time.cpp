#include <iostream>

int main(int argc, char **argv)
{
	unsigned int sec;
	int nsec;
	double d_sec;
	struct timespec start_time, end_time;

	if (argc != 3)
	{
		std::cerr << "time.cpp:Invalid argument" << std::endl;
		exit(EXIT_FAILURE);
	}
	std::string pid = argv[1];
	std::string file = argv[2];

	std::string s = "./client  `cat `";
	s.insert(9, pid);
	s.insert(15 + pid.length(), file);
	const char *command = s.c_str();
	/* 処理開始前の時間を取得 */
	clock_gettime(CLOCK_REALTIME, &start_time);
	/* 時間を計測する処理 */
	std::system(command);
	/* 処理開始後の時間とクロックを取得 */
	clock_gettime(CLOCK_REALTIME, &end_time);
	/* 処理中の経過時間を計算 */
	sec = end_time.tv_sec - start_time.tv_sec;
	nsec = end_time.tv_nsec - start_time.tv_nsec;
	d_sec = (double)sec + (double)nsec / (1000 * 1000 * 1000);
	/* 計測時間の表示 */
	printf("%f\n", d_sec);
	return 0;
}
