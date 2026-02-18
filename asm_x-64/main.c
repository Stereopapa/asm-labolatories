#include <stdio.h>

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


int main() {
	find_max_task();
	return 0;
}