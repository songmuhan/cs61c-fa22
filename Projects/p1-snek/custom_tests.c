#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "asserts.h"
// Necessary due to static functions in state.c
#include "state.c"

/* Look at asserts.c for some helpful assert functions */

int greater_than_forty_two(int x) { return x > 42; }

bool is_vowel(char c) {
  char* vowels = "aeiouAEIOU";
  for (int i = 0; i < strlen(vowels); i++) {
    if (c == vowels[i]) {
      return true;
    }
  }
  return false;
}

/*
  Example 1: Returns true if all test cases pass. False otherwise.
    The function greater_than_forty_two(int x) will return true if x > 42. False otherwise.
    Note: This test is NOT comprehensive
*/
bool test_greater_than_forty_two() {
  int testcase_1 = 42;
  bool output_1 = greater_than_forty_two(testcase_1);
  if (!assert_false("output_1", output_1)) {
    return false;
  }

  int testcase_2 = -42;
  bool output_2 = greater_than_forty_two(testcase_2);
  if (!assert_false("output_2", output_2)) {
    return false;
  }

  int testcase_3 = 4242;
  bool output_3 = greater_than_forty_two(testcase_3);
  if (!assert_true("output_3", output_3)) {
    return false;
  }

  return true;
}

/*
  Example 2: Returns true if all test cases pass. False otherwise.
    The function is_vowel(char c) will return true if c is a vowel (i.e. c is a,e,i,o,u)
    and returns false otherwise
    Note: This test is NOT comprehensive
*/
bool test_is_vowel() {
  char testcase_1 = 'a';
  bool output_1 = is_vowel(testcase_1);
  if (!assert_true("output_1", output_1)) {
    return false;
  }

  char testcase_2 = 'e';
  bool output_2 = is_vowel(testcase_2);
  if (!assert_true("output_2", output_2)) {
    return false;
  }

  char testcase_3 = 'i';
  bool output_3 = is_vowel(testcase_3);
  if (!assert_true("output_3", output_3)) {
    return false;
  }

  char testcase_4 = 'o';
  bool output_4 = is_vowel(testcase_4);
  if (!assert_true("output_4", output_4)) {
    return false;
  }

  char testcase_5 = 'u';
  bool output_5 = is_vowel(testcase_5);
  if (!assert_true("output_5", output_5)) {
    return false;
  }

  char testcase_6 = 'k';
  bool output_6 = is_vowel(testcase_6);
  if (!assert_false("output_6", output_6)) {
    return false;
  }

  return true;
}

/* Task 4.1 */

bool test_is_tail() {
  // TODO: Implement this function.
  printf("\ttest_is_tail ...\n");

  char str[] = "wasd";
  for(int i =0; i < strlen(str);i++){
    if(!is_tail(str[i])){
//        printf("\t \t test_is_tail: %c %d",str[i],is_tail(str[i]));
        return false;
    }
  }
  char str1[] = "qer"; // other code.
  for(int i =0; i < strlen(str1);i++){
    if(is_tail(str1[i])){
        return false;
    }
  }

  if(is_tail('\0')){
    return false;
  }
  return true;
}

bool test_is_head() {
  // TODO: Implement this function.
    printf("\ttest_is_head ...\n");
    char str[] = "WASDx";
    for(int i =0; i < strlen(str);i++){
        if(!is_head(str[i])){
    //        printf("\t \t test_is_tail: %c %d",str[i],is_tail(str[i]));
            return false;
        }
    }
    char str1[] = "qerwasd"; // other code.
    for(int i =0; i < strlen(str1);i++){
        if(is_head(str1[i])){
            return false;
        }
    }
    
    if(is_head('\0')){
        return false;
    }
    return true;
}

bool test_is_snake() {
    printf("\ttest_is_snake ...\n");
    char str[] = "wasd^<v>WASDx";
    for(int i =0; i < strlen(str);i++){
        if(!is_snake(str[i])){
    //        printf("\t \t test_is_tail: %c %d",str[i],is_tail(str[i]));
            return false;
        }
    }
    char str1[] = "qernklj"; // other code.
    for(int i =0; i < strlen(str1);i++){
        if(is_snake(str1[i])){
            return false;
        }
    }
    
    if(is_snake('\0')){
        return false;
    }
    return true;
}

bool test_body_to_tail() {
    printf("\ttest_body_to_tail ...\n");
    char str[] = "^<v>";
    char str1[] = "wasd";
    for(int i =0; i < strlen(str);i++){
        assert_equals_char("test_body_to_tail",body_to_tail(str[i]),str1[i]);
    }
  return true;
}

bool test_head_to_body() {
    printf("\ttest_head_to_body ...\n");
    char str[] = "WASD";
    char str1[] = "^<v>";
    for(int i =0; i < strlen(str);i++){
        assert_equals_char("test_body_to_tail",head_to_body(str[i]),str1[i]);
    }
  return true;
}

bool test_get_next_x() {
  // TODO: Implement this function.
  printf("\ttest_get_next_x ...\n");
  char up[] = "^wW";
  for(int i =0; i < strlen(up);i++){
    assert_equals_unsigned_int("test_get_next_x",get_next_row(5,up[i]),4u);
  }
  char down[] = "vsS";
  for(int i =0; i < strlen(down);i++){
    assert_equals_unsigned_int("test_get_next_x",get_next_row(0,down[i]),1u);
  }
  return true;
}

bool test_get_next_y() {
  // TODO: Implement this function.
  printf("\ttest_get_next_y ...\n");
  char left[] = "<aA";
  for(int i =0; i < strlen(left);i++){
    assert_equals_unsigned_int("test_get_next_y",get_next_col(5,left[i]),4u);
  }
  char right[] = ">dD";
  for(int i =0; i < strlen(right);i++){
    assert_equals_unsigned_int("test_get_next_x",get_next_col(0,right[i]),1u);
  }
  return true;
}



bool test_customs() {
  if (!test_greater_than_forty_two()) {
    printf("%s\n", "test_greater_than_forty_two failed.");
    return false;
  }
  if (!test_is_vowel()) {
    printf("%s\n", "test_is_vowel failed.");
    return false;
  }
  if (!test_is_tail()) {
    printf("%s\n", "test_is_tail failed");
    return false;
  }
  if (!test_is_head()) {
    printf("%s\n", "test_is_head failed");
    return false;
  }
  if (!test_is_snake()) {
    printf("%s\n", "test_is_snake failed");
    return false;
  }
  if (!test_body_to_tail()) {
    printf("%s\n", "test_body_to_tail failed");
    return false;
  }
  if (!test_head_to_body()) {
    printf("%s\n", "test_head_to_body failed");
    return false;
  }
  if (!test_get_next_x()) {
    printf("%s\n", "test_get_next_x failed");
    return false;
  }
  if (!test_get_next_y()) {
    printf("%s\n", "test_get_next_y failed");
    return false;
  }
  return true;
}

int main(int argc, char* argv[]) {
  init_colors();

  if (!test_and_print("custom", test_customs)) {
    return 0;
  }

  return 0;
}
