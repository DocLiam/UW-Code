// ==> (means implies)
// div (assumes integer division, which rounds down)

// Here I used a proof method based on finding the weakest precondition to imply a given desired postcondition (this way of proving programs correct was invented by Edsger W. Dijkstra)

// P : A is sorted and A[0] <= key <= A[n-1] (so the key is in the range [A[0],A])
// Then ==> n > 0
//
// Let m denote the minimum index such that A[m] >= key
// m is not a program variable, but rather a abstract variable for reasoning
// Q : m has been found (later we show which variables contain m)

// Want to find m:


// {P} S0 {Q} can be expanded to:

// {P}                                                  (Our precondition)
// S1                                                   (Some preparation statements)
// {Invariant I : let this be l <= m <= h}              (Chosen because in the loop we adjust l and h so that m falls in)
// {Variant V : h-l}
//
// while G do
//      {I and G}
//      S2
//      {I and V has progressed}
// end
//
// {I and G'}
// {Q}

// Given we want to establish Q, we need I and G', so just I is not enough
// With I, we have that l <= m <= h, so to satisfy Q, we consider l = h, which means l <= m <= h
// equivalent to l = m = h
// equivalent to m has been found, so Q is satisfied
// G' is l = h, so G is l != h

// {P} S1 {I} can be expanded to:

// {P} (seq l=0 h=n-1) {I}
// We can that this step is correct, by showing P ==> (I[h/n-1])[l/0]
// (I[h/n-1])[l/0] equivalent to ((l <= m <= h)[h/n-1])[l/0]
// equivalent to (l <= m <= n-1)[l/0]
// equivalent to (0 <= m <= n-1)
// which is clearly implied by P

// Consider {I and G} S2 {I}, given we want to re-establish I after S2 and we want to progress V, we have to change l and h or both
// Given we are doing binary search, we know we will need an if statement involving a midpoint of l and h
// I equivalent to l <= m <= h
// equivalent to (l <= m <= (l+h)div2 OR (l+h)div2+1 <= m <= h)
// The first option is true if and only if key <= A[(l+h)div2], so we will use this as the first condition of the if statement
//
// So {I and G} S2 {I} can be expanded to:

// {I and G}
// if key <= A[((l+h)div2] then
//      {I and G and key <= A[((l+h)div2] and l <= m <= (l+h)div2}
//      S3
//      {I}
// else then
//      {I and G and A[((l+h)div2+1] <= key and (l+h)div2+1 <= m <= h}
//      S4
//      {I}
// end
// {I and V has progressed}

// {I and G and key <= A[((l+h)div2] and l <= m <= (l+h)div2} S3 {I} can be expanded to:

//      {I and G and key <= A[((l+h)div2] and l <= m <= (l+h)div2}
//      h = ((l+h)div2
//      {I}
// We can see this is valid by considering I[h/((l+h)div2] equivalent to (l <= m <= h)[h/((l+h)div2]
// equivalent to (l <= m <= (l+h)div2)
// clearly implied by I and key <= A[((l+h)div2] and l <= m <= (l+h)div2

// {I and G and A[((l+h)div2+1] <= key and (l+h)div2+1 <= m <= h} S4 {I} can be expanded to:

//      {I and G and A[((l+h)div2+1] <= key and (l+h)div2+1 <= m <= h}
//      l = ((l+h)div2+1
//      {I}
// We can see this is valid by considering I[l/((l+h)div2+1] equivalent to (l <= m <= h)[l/((l+h)div2+1]
// equivalent to ((l+h)div2+1 <= m <= h)
// clearly implied by I and A[((l+h)div2+1] <= key and (l+h)div2+1 <= m <= h

// In both paths through the if statements, V progressed because h-l decreases
// This proves termination, since eventually l=h, so G is false, and V = 0


// Here is the program without annotations:

// {P}                                                
// (seq l=0 h=n-1)                                      
// {Invariant I : let this be l <= m <= h}       
// {Variant V : h-l}
//
// while l != h do
//      if key <= A[((l+h)div2] then
//          h = (l+h)div2
//      else then
//          l = (l+h)div2+1
//      end
// end
// {Q : m is found and l = m = h}

int lowsearch(int A[], int key, int n) {
    // Because it was provided that we can assume key <= A[n-1] for our proof, but not for the C program itself, we add this condition to immediately check if key is within the range defined by A[0] and A[n-1]
    // If key is greater than A[n-1], we have that m does not satisfy l <= m <= h, so we therefore return n immediately
    // If key is within the range from A[0] to A[n-1], we have that l <= m <= h, and so we have this satifying our precondition P, which let's us proceed with the C program as we have proven
    if (A[n-1] < key) 
        return n;
    else {
        int l = 0;
        int h = n-1;

        while (l != h) {
            int mid = (l+h)/2; // introduce a local shorthand variable unlike the pseudocode proof

            if (key <= A[mid])
                h = mid;
            else
                l = mid+1;
        }
        
        return l; // this could just as easily have been h
    }
}