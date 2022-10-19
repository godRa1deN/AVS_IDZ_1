#include <stdio.h>

int f(int t) {
    int g = 10;
    return g*t*t/2;
}

int main() {
    int a[100000];
    int n;
    scanf("%d", &n);
    for (int i = 0; i < n; i++) {
        scanf("%d", &a[i]);
    }
    int b[100000];
    for (int i = 0; i < n; i++) {
        b[i] = f(a[i]);
    }
    for (int i = 0; i < n; i++) {
        printf("%d ", b[i]);
    }
}
