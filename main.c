#include <stdio.h>
#include <stdint.h>

int main(	)
{
	unsigned int c[] = {0x42, 0x30, 0x82};
	for (int i = 0; i < 2; i++)
	{
		printf("%c",c[i]);
	}
}
