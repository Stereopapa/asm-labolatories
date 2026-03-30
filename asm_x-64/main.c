#include <stdio.h>

void print_array(int* tab, int n) {
	printf("[ ");
	for (int i = 0; i < n; i++)
	{
		printf("%d ", tab[i]);
	}
	printf("]\n");
}

extern __int64 find_max(__int64* tab, __int64 n);
void find_max_task() {
	__int64 results[12] = { -15, 4000000, -345679, 88046592,
							-1, 2297645, 7867023, -19000444, 31,
							456000000000000,
							444444444444444,
							-123456789098765 };
	__int64 max_val = find_max(results, 12);

	printf("\nMax: %I64d\n", max_val);
}

extern void fir_filter(const int N, const int L, int* input, int* output, int* coefs, int* delay);
void fir_filter_task() {
#define N 32
#define L 16
	int input[N] = {
	0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0A,
	0x0B, 0x0C, 0x0D, 0x0E, 0x0F, 0x10, 0x11, 0x12, 0x13, 0x14,
	0x15, 0x16, 0x17, 0x18, 0x19, 0x1A, 0x1B, 0x1C, 0x1D, 0x1E,
	0x1F, 0x20
	};
	int output[N] = { 0 };
	int delay[L] = {
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	};

	int coefs[L] = {
		1, 1, 1, 1, 1, 1, 1, 1,
		1, 1, 1, 1, 1, 1, 1, 1
	};

	fir_filter(N, L, input, output, coefs, delay);
	printf("Coefs\n");
	print_array(coefs, L);
	printf("Input\n");
	print_array(input, N);
	printf("Output\n");
	print_array(output, N);

}


int main() {
	//find_max_task();
	fir_filter_task();
	return 0;
}