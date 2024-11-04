package multiplicacionRusse.algos;
public class multiplicacionRusse {
    public static int russ(int A, int B){
        int[] X = new int[100];
        int[] Y = new int[100];
        int i = 0;
        X[0] = A;
        Y[0] = B;

        while (X[i]>1) {
            X[i+1] = X[i] / 2;
            Y[i+1] = Y[i] + Y[i];
            i++;
        }

        int prod = 0;
        while (i>0){
            if (X[i] % 2 == 1){
                prod = prod + Y[i];
                i--;
            }
        }
        return prod;

    }
    public static void main(String[] args) {
           System.out.println(russ(2, 50)); 
    }
}