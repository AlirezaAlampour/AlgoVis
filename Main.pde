
Button button;//Buttons
Button button1;
Button button2;
Button button3;
Button button4;
Button button5;

String algo;
String showAlgo;

int numBars; //Number of elements to sort
int time;
int[] input; //array
int progress; //how far algorithm has sorted
int iterator; //what algorithm is currently iterating through
int it2;
int specialIndex; //special index
int comparisons;
int arrayAccesses;
float delay; //Delay

boolean pressed;
boolean running;
boolean sorted;

void setup() {
  running = true;
  algo = "";
  numBars = 150;
  progress = -1;
  iterator = -1;
  it2 = -1;
  specialIndex = -1;
  comparisons = 0;
  arrayAccesses = 0;
  delay = .1;
  //fullScreen();
  size(1060, 620); //1040,585
  button = new Button("Heap", 200, 300, 80, 30);
  button1 = new Button("Selection", 300, 300, 80, 30);
  button2 = new Button("Insertion", 400, 300, 80, 30);
  button3 = new Button("Merge", 500, 300, 80, 30);
  button4 = new Button("Quick", 600, 300, 80, 30);
  button5 = new Button("Bubble", 700, 300, 80, 30);
  noStroke();
  stroke(0);
  input = getRandomArray(numBars);
}

void draw() {
  if(keyPressed){
    if(key == 'c' || key == 'C'){
      pressed = false;
      running =true;
      setup();
    }
  }
  MouseIsOver();
  background(0);
  fill(255);
  if(!pressed){
  button.Draw();
  button1.Draw();
  button2.Draw();
  button3.Draw();
  button4.Draw();
  button5.Draw();
  }if(pressed){
    int currentTime = millis()/1000-time;
    text("Time in seconds: " + currentTime, 65, 15);
    text(showAlgo +"Sort", 65, 35);
    drawArray(input);
    if(running){
      thread("doSort");
      running = false;
      sorted = true;
    }
  }
}


void mousePressed(){
  if(algo!="false"){
  time = millis()/1000;
  pressed = true;
  }
}
  void MouseIsOver(){
    if (mouseX > 200 && mouseX < (200 + 80) && mouseY > 300 && mouseY < (300 + 30)){
      algo = button.label;
    }
    else if(mouseX > 300 && mouseX < (300 + 80) && mouseY > 300 && mouseY < (300 + 30)){
      algo = button1.label;
    }
    else if(mouseX > 400 && mouseX < (400 + 80) && mouseY > 300 && mouseY < (300 + 30)){
      algo = button2.label;
    }
    else if(mouseX > 500 && mouseX < (500 + 80) && mouseY > 300 && mouseY < (300 + 30)){
      algo = button3.label;
    }
    else if(mouseX > 600 && mouseX < (600 + 80) && mouseY > 300 && mouseY < (300 + 30)){
      algo = button4.label;
    }
    else if(mouseX > 700 && mouseX < (700 + 80) && mouseY > 300 && mouseY < (300 + 30)){
      algo = button5.label;
    }
    else algo = "false";
  }

void doSort(){
  showAlgo = algo;
  switch(algo){
  case "Heap":
    heapSort(input);
    break;
  case "Selection":
    selectionSort(input);
    break;
  case "Bubble":
    bubbleSort1(input);
    break;
  case "Insertion":
    insertionSort(input);
    break;
  case "Merge":
    mergeSort(input);
    break;
  case "Quick":
    quicksort(input);
    break;
  default:
    selectionSort(input);
  }
}

void quicksort(int[] a){
  quicksort(a, 0, a.length-1);
}

void quicksort(int[] a, int low, int high){
  if(low >= high){
    return;
  }
  
  int i = low;
  int j = high;
  //pivot is median of three random values
  int p = (low+high)/2;
  int pivot = a[p];
  specialIndex = p;

  while (i <= j) {
    while (a[i] < pivot){
      i++;
      delay(delay);
    }
    while (a[j] > pivot){
      j--;
      delay(delay);
    }
    if (i <= j) {
      swap(a, i, j);
      i++;
      j--;
      delay(delay);
    }
  }
  println(low,j,i,high);
  if (low < j){
    quicksort(a, low, j);
  }
  if (i < high){
    quicksort(a, i, high);
  }
}

void mergeSort(int[] a){
  mergeSort(a, 0, a.length);
  iterator = it2 = -1;
  runThrough(a);
}

void mergeSort(int[] a, int low, int high){
  if (low + 1 < high) {
    int mid = (low + high)/2;
    mergeSort(a, low, mid);
    mergeSort(a, mid, high);

    merge(a, low, mid, high);
  }
}

void merge(int[] a, int low, int mid, int high){
  int[] temp = new int[high-low];
  int i=low;
  int j=mid;
  int k = -1;

  while (k < temp.length-1){
    iterator = i;
    it2 = j;
    //comparisons++;
    temp[++k] = (j > high-1 || (i <= mid-1 && a[i] < a[j])) ? a[i++] : a[j++];
    comparisons ++;
    arrayAccesses += 2;
    delay(delay);
  }
  it2 = -1;

  for (i=0; i<temp.length; i++){
    iterator = low + i;
    a[low + i] = temp[i];
    arrayAccesses++;
    delay(delay);
  }
}

//Insertion sort
void insertionSort(int[] a){
  for (int i=1; i<a.length; i++){
    int val = a[i];
    arrayAccesses++;
    progress = i;

    int j = i-1;
    while (j>=0 && a[j] > val){
      comparisons++;
      arrayAccesses++;
      iterator = j;
      swap(a, j, j+1);
      j--;
      delay(delay);
    }
  }
  iterator = -1;
  runThrough(a);
  progress = -1;
}



//Bubble Sort
public void bubbleSort1(int arr[]){ 
  for (int i = 0; i < arr.length-1; i++) 
    for (int j = 0; j <arr.length-i-1; j++){
      iterator =j;
      if (arr[j] > arr[j+1]){ 
        // swap arr[j+1] and arr[j] 
        int temp = arr[j]; 
        arr[j] = arr[j+1]; 
        arr[j+1] = temp;
        delay(delay);
      }
    }
  iterator = -1;
  runThrough(arr);
  progress = -1;
    }


//Selection sort
void selectionSort(int[] arr){
  int n = arr.length;
  int i=0;
  int min=0;
  while (i < n) {
    min = i;
    for (int j=i+1; j<n; j++){
      iterator = j;
      if (arr[j] < arr[min]) {
        min = specialIndex = j;
      }
      comparisons++; 
      arrayAccesses+=2;
      delay(delay);
    }
    swap(arr, i, min);
    progress = i;
    i++;
  }
  iterator = specialIndex = -1;
  runThrough(arr);
  progress = -1;
}

void runThrough(int[] a){
  for (int i=0; i<a.length; i++){
    progress = i;
    delay(delay+5);
  }
}

//Heap sort
public void heapSort(int arr[]){ 
  int n = arr.length;   
  // Build heap (rearrange array) 
  for(int i = n / 2 - 1; i >= 0; i--){ 
    heapHelper(arr, n, i);
  }
  for(int i=n-1; i>0; i--){ 
    int temp = arr[0]; 
    arr[0] = arr[i]; 
    arr[i] = temp;  
    // call max helper on the reduced heap
    delay(delay);
    heapHelper(arr, i, 0);
    iterator = -1;
    runThrough(arr);
    progress = -1;
  } 
} 
//HeapSort helper
void heapHelper(int arr[], int n, int i){ 
  int largest = i; // Initialize largest as root 
  int l = 2*i + 1; // left = 2*i + 1 
  int r = 2*i + 2; // right = 2*i + 2 
  // If left child is larger than root 
  if(l < n && arr[l] > arr[largest])
    largest = l; 
  // If right child is larger than largest so far 
  if(r < n && arr[r] > arr[largest]) 
    largest = r; 
  // If largest is not root 
  if(largest != i){ 
    int swap = arr[i]; 
    arr[i] = arr[largest]; 
    arr[largest] = swap; 
    // Recursively 
    heapHelper(arr, n, largest); 
  } 
}


//Draw rectangles showing the elements of the array
void drawArray(int[] a){
  int n=a.length;
  strokeWeight(100/n);
  float x_inc = 1040*(1.0/n); //multi factor x
  float y_inc = 585.0/n; //multi factor y
  for (int i=0; i<n; i++){
    int val = a[i];
    if (i == progress){
      fill(62, 0, 252);
    } else if (i == iterator || i == it2){
      fill(180, 180, 180);
    } else if (i == specialIndex){
      fill(180, 180, 180);
    } else{
      fill(180);
    }
    rect(10+i*x_inc, 615-(val*y_inc), x_inc, val*y_inc);
  }
     //text("Comparisons: " + comparisons, 10, 15);
    //text("Array accesses: " + arrayAccesses, 150, 15);
}

//Returns random array
int[] getRandomArray(int n){
  int[] a = new int[n];
  for (int i=0; i<n; i++){
    a[i] = i+1;
  }
  shuffle(a);
  return a;
}

//Durstenfeld's Fisher-Yates algorithm for random order
void shuffle(int[] a){
  int n = a.length;
  for (int i=0; i<n-1; i++){
    int j = (int) random(0, n-i);
    swap(a, i, i+j);
  }
}

//Swaps array elements
void swap(int[] a, int i, int j){
  if (i == j) return;
  int temp = a[i];
  a[i] = a[j];
  arrayAccesses+=2;
  a[j] = temp;
}

void delay(float millis){
  int nanos = (int) ((millis % 1)*1000000);
  try{
    Thread.sleep((int) millis, nanos);
  } 
  catch(InterruptedException e){
    println("oops");
  }
}
