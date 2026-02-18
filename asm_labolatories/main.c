#include <stdio.h>
#include <windows.h>
#include <xmmintrin.h>

//small procedures
void xor_equivalence();
void u2_to_sign_magnitude_conversion();
void rcl_three_registers();
void be_to_le_without_bswap();
void counting_set_bits_in_eax();
void mul_without_mul();
void mul_with_lea();
void saving_adress_var_in_same_var();
void misc();
void sum_of_digit_in_decimal();
int utf16_bytes_am_cnvrtd_from_utf8();
void free_days_display();
void xor_swap();
void utf16_cp_basic_ascii();
void rcl_1024b_mem_reg();
void u2_to_negbinary();
void save_5_specfic_bits();
void fixed_point_display();
void decimal_to_bcd();
void cmp_decimal_in_ascii();
void num64b_in_32b_mode(long long);
void printing_win1250_and_unicode();
void display_eax_hex_task();

//medium procedures
void printArray(int* tab, int n) {
	printf("\n[ ");
	for (int i = 0; i < n; i++)
	{
		printf("%d ", tab[i]);
	}
	printf("]\n");
}

void printArrayLong(unsigned __int64* tab, int n) {
	printf("\n[ ");
	for (int i = 0; i < n; i++)
	{
		printf("%llu ", tab[i]);
	}
	printf("]\n");
}

int difference(int* minuend, int** subtrahend);
void difference_task() {
	int a, b, * ptr, result;
	ptr = &b;
	a = 21; b = 25;
	result = difference(&a, &ptr);
	printf("%d", result);
}

int* copy_array(int tab1[], unsigned int n);
void copy_array_task() {
	int tab[] = { 0, 2, 1, -2, -5, 6 };
	int* tab2 = copy_array(tab, 6);
	printArray(tab2, 6);
}

char* message(char* text);
void message_task() {
	char* text = "this is text", * text2;
	text2 = message(text);
	printf("%s", text2);
}

int* find_min(int tab[], int n);
void find_min_task() {
	int measurements[] = { 1, -2, -1, 10, -3, 2, 8 };
	int* ptr;
	ptr = find_min(measurements, 7);
	printf("%d", *ptr);
}

int* find_max(int tab[], int n);
void find_max_task() {
	int measurements[] = { 1, -2, -1, 10, -3, 2, 8 };
	int* ptr;
	ptr = find_max(measurements, 7);
	printf("%d", *ptr);

}

void encrypt(char* text);
void encrypt_task() {
	char text[] = "is text";
	encrypt(text);
	printf("%s", text);

}
unsigned int square(unsigned int a);
void square_task() {
	int a = 65000;
	printf("%u", square(a));
}

unsigned char iteration(unsigned char a);
void iteration_task() {
	unsigned char w = iteration(32);
	unsigned int ww = (unsigned int)w;
	printf("Char : %u", ww);
}

void task8();

double to_double(float* num1, double* num2);
void to_double_task() {
	float num1 = 2.23;
	double num2 = 3.0;
	to_double(&num1, &num2);
	printf("%lf", num2);
}

void circle_area(float* r);
void circle_area_task() {
	float r = 2.0;
	circle_area(&r);
	printf("%f", r);
}

float weighted_avg(int n, void* array_ptr, void* weights_ptr);
void weighted_avg_task() {
	float numbers[] = { 1.0, 2.0, 3.0, 5.0 };
	float weights[] = { 1.0, 2.0, 1.0, 4.0 };
	printf("%f", weighted_avg(4, numbers, weights));
}

unsigned int cpu_count();
void cpu_count_task() {
	printf("%u", cpu_count());
}

unsigned __int64 sorting(unsigned __int64* tab1, unsigned int n);
void sorting_task() {
	unsigned __int64 tab[] = { 0, 1, 8, 2 };
	unsigned __int64 nw = sorting(tab, 4);
	printf("%llu", nw);
	printArrayLong(tab, 4);
}

wchar_t* ASCII_to_UTF16(char* chars, int n);
void ASCII_to_UTF16_task() {
	char chars[] = "some text2";
	wchar_t* charsUTF16 = ASCII_to_UTF16(chars, 13);
	MessageBoxW(0, charsUTF16, charsUTF16, 0);
}

void shl_128(__m128* a, char n);
void shl_128_task() {
	__m128 a[1] = { 0.0f, 0.0f, 0.0f, .0f };
	shl_128(a, 1);
}

void decrement(int**);
void decrement_task() {
	int k;
	int wsk = &k;

	printf("type decimal number\n");
	scanf_s("%d", &k);
	decrement(&wsk);

	printf("result = %d\n", k);
}

void swap_elements(int tab[], int n);
int abs_med(int tab[], int n);
void sort_array(int tab[], int n);
void print_array(int tab[], int n);
void find_median_task() {
	int tab[9] = { -5, 12, 1,-3, 11, -9, 2, 11, 3 };
	int n = 9, median;

	median = abs_med(tab, n);
	printf("\nmedian: %d\n", median);

	return 0;
}

void calc_roots_of_quadratic(float* roots, float a, float b, float c);
void calc_roots_of_quadratic_task() {
	float a = 2.0, b = -1, c = -15;
	float roots[2];
	calc_roots_of_quadratic(roots, a, b, c);
	printf("x1 = %.2f, x2 = %.2f", roots[0], roots[1]);
}

float exp_x(float x);
void exp_x_task() {
	float exp, x = 1;
	exp = exp_x(x);
	printf("e^%f = %f", x, exp);
}

float harmonical_mean(float* arr, unsigned int n);
void harmonical_mean_task() {
	float arr[] = { 3.0, 3.0 };
	int n = sizeof arr / sizeof arr[0];
	printf("%f", harmonical_mean(arr, n));
}

float exp_x_taylor_series(float x);
void exp_x_taylor_series_task() {
	float exp, x = 1;
	exp = exp_x_taylor_series(x);
	printf("e^%f = %f", x, exp);
}

double variance(double* arr, unsigned int n);
double average(double* arr, unsigned int n);
void variance_task() {
	double arr[2] = { 3.0, 4.0 };
	int n = sizeof arr / sizeof arr[0];
	printf("%lf", variance(arr, n));
}

//larger procedures
void latin_to_capital_windows1250_converter();
void display_arithmetic_sequence();

int main() {
	//xor_equivalence();
	//u2_to_sign_magnitude_conversion();
	//rcl_three_registers();
	//be_to_le_without_bswap();
	//counting_set_bits_in_eax();
	//mul_without_mul();
	//mul_with_lea();
	//saving_adress_var_in_same_var();
	//misc();
	//sum_of_digit_in_decimal();
	//printf("%d", utf16_bytes_am_cnvrtd_from_utf8());
	//free_days_display();
	//xor_swap();
	//utf16_cp_basic_ascii();
	//rcl_1024b_mem_reg();
	//u2_to_negbinary();
	//save_5_specfic_bits();
	//fixed_point_display();
	//decimal_to_bcd();
	//cmp_decimal_in_ascii();
	//num64b_in_32b_mode(0xFFFFFFFFFFFF);
	//printing_win1250_and_unicode();
	//display_eax_hex_task();
	//read_eax_hex_task();
	
	//difference_task();
	//copy_array_task();
	//message_task();
	//find_min_task();
	//find_max_task();
	//encrypt_task();
	//square_task();
	//iteration_task();
	//to_double_task();
	//circle_area_task();
	//weighted_avg_task();
	//cpu_count_task();
	//sorting_task();
	//ASCII_to_UTF16_task();
	//shl_128_task();
	//decrement_task();
	//find_median_task();
	//calc_roots_of_quadratic_task();
	//exp_x_task();
	//harmonical_mean_task();
	//exp_x_taylor_series_task();
	variance_task();

	//latin_to_capital_windows1250_converter();
	//display_arithmetic_sequence();
	return 0;
}