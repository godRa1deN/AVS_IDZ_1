#include <stdio.h>

int f(int t) {
    int g = 10;
    return g*t*t/2;
}

int main() {
    int a[10000];
    int b[10000];
    int n;
    scanf("%d", &n);
    if (n > 10000 || n < 0) {
        printf("Wrong size!");
        return -1;
    }
    for (int i = 0; i < n; i++) {
        scanf("%d", &a[i]);
        if (a[i] < 0 || a[i] > 10000) {
            b[i] = -1;
            printf("%d ", b[i]);         
        } else {
	    b[i] = f(a[i]);
	    printf("%d ", b[i]);
        }
    }
    return 0;
}
