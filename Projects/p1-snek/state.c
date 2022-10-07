#include "state.h"

#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "snake_utils.h"

/* Helper function definitions */
static void set_board_at(game_state_t* state, unsigned int row, unsigned int col, char ch);
static bool is_tail(char c);
static bool is_head(char c);
static bool is_snake(char c);
static char body_to_tail(char c);
static char head_to_body(char c);
static unsigned int get_next_row(unsigned int cur_row, char c);
static unsigned int get_next_col(unsigned int cur_col, char c);
static void find_head(game_state_t* state, unsigned int snum);
static char next_square(game_state_t* state, unsigned int snum);
static void update_tail(game_state_t* state, unsigned int snum);
static void update_head(game_state_t* state, unsigned int snum);

/* Task 1 */
game_state_t* create_default_state() {
  // TODO: Implement this function.
  game_state_t *game_state_t_pointer = (game_state_t *)malloc(sizeof(game_state_t));
  if(game_state_t_pointer == NULL){
    printf("exit at create_default_state #1\n");
    exit(1);
  }
  game_state_t_pointer->num_rows = 18;

  game_state_t_pointer->num_snakes = 1;
  // NOTICE: potential bug of snake array
 
  game_state_t_pointer->snakes = (snake_t *)malloc(game_state_t_pointer->num_snakes * sizeof(snake_t));
  game_state_t_pointer->snakes[0].tail_row = 2;
  game_state_t_pointer->snakes[0].tail_col = 2;
  game_state_t_pointer->snakes[0].head_row = 2;
  game_state_t_pointer->snakes[0].head_col = 4;
  game_state_t_pointer->snakes[0].live = true;




/*
  game_state_t_pointer->snakes[1].tail_row = 2;
  game_state_t_pointer->snakes[1].tail_col = 2;
  game_state_t_pointer->snakes[1].head_row = 2;
  game_state_t_pointer->snakes[1].head_col = 4;
  game_state_t_pointer->snakes[1].live = true;

  // snakes = malloc(sizeof(snake_t *));

  printf("----------------\n");
  printf("snakes_pointer %p, snakes[0] %p, snakes[1] %p\n",&game_state_t_pointer->snakes,&game_state_t_pointer->snakes[0],&game_state_t_pointer->snakes[1]);
  printf("sizeof snakes_pointer %ld, sizeof snake_t %ld\n",sizeof(game_state_t_pointer->snakes),sizeof(snake_t));
  printf("----------------\n");
*/


  game_state_t_pointer->board = malloc(18 * sizeof(char*));
  char *FirstAndLastRow  = "####################\n";
  char *SnakeAndFruitRow = "# d>D    *         #\n";
  char *OtherRow = "#                  #\n";
  game_state_t_pointer->board[0] = (char *)malloc((strlen(FirstAndLastRow)+ 1));
  strcpy(game_state_t_pointer->board[0],FirstAndLastRow);
  game_state_t_pointer->board[17] = (char *)malloc((strlen(FirstAndLastRow)+ 1));
  strcpy(game_state_t_pointer->board[17],FirstAndLastRow);
  game_state_t_pointer->board[2] = (char *)malloc((strlen(SnakeAndFruitRow)+ 1));
  strcpy(game_state_t_pointer->board[2],SnakeAndFruitRow);
  game_state_t_pointer->board[1] = (char *)malloc((strlen(OtherRow)+ 1));
  strcpy(game_state_t_pointer->board[1],OtherRow);
  for(int i = 3; i < 17;i++){
    game_state_t_pointer->board[i] = (char *)malloc((strlen(OtherRow)+ 1));
    strcpy(game_state_t_pointer->board[i],OtherRow);
  }
  return game_state_t_pointer;
}

/* Task 2 */
void free_state(game_state_t* state) {
  // TODO: Implement this function.

  // step 1: free snakes
  free(state->snakes);
  for(int i = 0; i < state->num_rows;i++){
    free(state->board[i]);
  }
  free(state->board);
  free(state);
  return;
}

/* Task 3 */
void print_board(game_state_t* state, FILE* fp) {
  // TODO: Implement this function.
  for(int i =0; i < state->num_rows; i++){
    fprintf(fp,"%s",state->board[i]);
  }
  return;
}

/*
  Saves the current state into filename. Does not modify the state object.
  (already implemented for you).
*/
void save_board(game_state_t* state, char* filename) {
  FILE* f = fopen(filename, "w");
  print_board(state, f);
  fclose(f);
}

/* Task 4.1 */

/*
  Helper function to get a character from the board
  (already implemented for you).
*/
char get_board_at(game_state_t* state, unsigned int row, unsigned int col) {
  return state->board[row][col];
}

/*
  Helper function to set a character on the board
  (already implemented for you).
*/
static void set_board_at(game_state_t* state, unsigned int row, unsigned int col, char ch) {
  state->board[row][col] = ch;
}

/*
  Returns true if c is part of the snake's tail.
  The snake consists of these characters: "wasd"
  Returns false otherwise.
*/
static bool is_tail(char c) {
  // TODO: Implement this function.
  return (c == 'w' || c=='a' || c=='s' || c=='d');
}

/*
  Returns true if c is part of the snake's head.
  The snake consists of these characters: "WASDx"
  Returns false otherwise.
*/
static bool is_head(char c) {
  // TODO: Implement this function.
  return  (c == 'W' || c=='A' || c=='S' || c=='D' || c == 'x');
}

/*
  Returns true if c is part of the snake.
  The snake consists of these characters: "wasd^<v>WASDx"
*/
static bool is_snake(char c) {
  // TODO: Implement this function.
  return (is_head(c) || is_tail(c) || c =='^' || c=='<' || c == 'v'||c=='>');
}

/*
  Converts a character in the snake's body ("^<v>")
  to the matching character representing the snake's
  tail ("wasd").
*/
static char body_to_tail(char c) {
  // TODO: Implement this function.
  char new;
  if(c == '^') new = 'w';
  else if (c == '<') new = 'a';
  else if (c == 'v') new = 's';
  else if (c == '>' ) new = 'd';
  return new;
}

/*
  Converts a character in the snake's head ("WASD")
  to the matching character representing the snake's
  body ("^<v>").
*/
static char head_to_body(char c) {
  // TODO: Implement this function.
  char new;
  if(c == 'W') new = '^';
  else if (c == 'A') new = '<';
  else if (c == 'S') new = 'v';
  else if (c == 'D' ) new = '>';
  return new;
}

/*
  Returns cur_row + 1 if c is 'v' or 's' or 'S'.
  Returns cur_row - 1 if c is '^' or 'w' or 'W'.
  Returns cur_row otherwise.
*/
static unsigned int get_next_row(unsigned int cur_row, char c) {
  // TODO: Implement this function.
  if(c == 'v' || c == 's' || c =='S') return cur_row + 1;
  else if(c == '^' || c == 'w' || c == 'W') return cur_row - 1;
  return cur_row;
}

/*
  Returns cur_col + 1 if c is '>' or 'd' or 'D'.
  Returns cur_col - 1 if c is '<' or 'a' or 'A'.
  Returns cur_col otherwise.
*/
static unsigned int get_next_col(unsigned int cur_col, char c) {
  // TODO: Implement this function.
  if(c == '>' || c == 'd' || c == 'D') return cur_col + 1;
  else if(c == '<' || c == 'a' || c == 'A') return cur_col - 1;
  return cur_col;
}

/*
  Task 4.2

  Helper function for update_state. Return the character in the cell the snake is moving into.

  This function should not modify anything.
*/
static char next_square(game_state_t* state, unsigned int snum) {
  // TODO: Implement this function.
  unsigned int next_col,next_row;
  char head = get_board_at(state,state->snakes[snum].head_row,state->snakes[snum].head_col);
  next_col = get_next_col(state->snakes[snum].head_col,head);
  next_row = get_next_row(state->snakes[snum].head_row,head);
  return get_board_at(state, next_row, next_col);
}

/*
  Task 4.3

  Helper function for update_state. Update the head...

  ...on the board: add a character where the snake is moving

  ...in the snake struct: update the row and col of the head

  Note that this function ignores food, walls, and snake bodies when moving the head.
*/
static void update_head(game_state_t* state, unsigned int snum) {
  // TODO: Implement this function.
  char head = get_board_at(state,state->snakes[snum].head_row,state->snakes[snum].head_col);
  unsigned int next_col = get_next_col(state->snakes[snum].head_col,head);
  unsigned int next_row = get_next_row(state->snakes[snum].head_row,head);
  set_board_at(state,next_row,next_col,head);

  char body = head_to_body(head);
  set_board_at(state,state->snakes[snum].head_row,state->snakes[snum].head_col,body);

  state->snakes[snum].head_col = next_col;
  state->snakes[snum].head_row = next_row;

  return;
}

/*
  Task 4.4

  Helper function for update_state. Update the tail...

  ...on the board: blank out the current tail, and change the new
  tail from a body character (^<v>) into a tail character (wasd)

  ...in the snake struct: update the row and col of the tail
*/

char helper_find_body(game_state_t * state, unsigned int snum){
    char tail = get_board_at(state,state->snakes[snum].tail_row,state->snakes[snum].tail_col);
    unsigned int row = state->snakes[snum].tail_row;
    unsigned int col = state->snakes[snum].tail_col;
    if(tail == 'w'){ 
        row = row - 1;
    }
    else if(tail == 'a'){
        col = col - 1;
    }
    else if(tail == 's'){
        row = row + 1;
    }
    else if(tail == 'd'){
        col = col + 1;
    }
    return  get_board_at(state,row,col);
}


static void update_tail(game_state_t* state, unsigned int snum) {
  // TODO: Implement this function.

  char tail = get_board_at(state,state->snakes[snum].tail_row,state->snakes[snum].tail_col);
  char body = helper_find_body(state,snum);

  unsigned int next_col = get_next_col(state->snakes[snum].tail_col,tail);
  unsigned int next_row = get_next_row(state->snakes[snum].tail_row,tail);
  set_board_at(state,state->snakes[snum].tail_row,state->snakes[snum].tail_col,' ');
 
  set_board_at(state,next_row,next_col,body_to_tail(body));
  state->snakes[snum].tail_col = next_col;
  state->snakes[snum].tail_row = next_row;

  return;
}

/* Task 4.5 */
void update_state(game_state_t* state, int (*add_food)(game_state_t* state)) {
  char next;
  for(unsigned int i = 0; i < state->num_snakes;i++){
    if(!state->snakes[i].live)
        continue;
    next = next_square(state,i);
    if(next == '#' || is_snake(next)){
        set_board_at(state,state->snakes[i].head_row,state->snakes[i].head_col,'x');
        state->snakes[i].live = false;
        continue;
    }
    else if(next == '*'){
        update_head(state,i);
        add_food(state);
    }
    else{
     //   printf("here?\n");
        update_head(state,i);
        update_tail(state,i);
    }
    
  }
  return;
}

/* Task 5 */
game_state_t* load_board(char* filename) {
  // TODO: Implement this function.
  game_state_t* state;
  state = (game_state_t *)malloc(sizeof(game_state_t));
  if(state == NULL){
    printf("load_board: fail to malloc memory to state\n");
    return NULL;
  }

  FILE *fp = fopen(filename,"r");
  if(fp == NULL){
    printf("load_board: fail to open file %s.\n",filename);
    return NULL;
  }

  char line[200000];
  unsigned int i = 0;
  while(fgets(line,200000,fp)){
       i ++;
  }

  state->num_rows = i;
  state->board = malloc(state->num_rows * (sizeof(char *)));

  if(state->board == NULL){
    printf("load_board: fail to malloc memory to state->board\n");
    return NULL;
  }



  rewind(fp);
  i = 0;
  while(fgets(line,200000,fp)){
  //    printf("len   %8s",line);
       state->board[i] = (char *)malloc(strlen(line)+1);
       strcpy(state->board[i],line);
 //    printf("board %8s\n",state->board[i]);
       i ++;
  }

  return state;
}

/*
  Task 6.1

  Helper function for initialize_snakes.
  Given a snake struct with the tail row and col filled in,
  trace through the board to find the head row and col, and
  fill in the head row and col in the struct.
*/
static void find_head(game_state_t* state, unsigned int snum) {
  // TODO: Implement this function.
   unsigned int cur_row = state->snakes[snum].tail_row;
   unsigned int cur_col = state->snakes[snum].tail_col;
   
  char current = get_board_at(state,cur_row,cur_col);
  if(current == 'w') cur_row --;
  else if(current == 'a') cur_col --;
  else if(current == 's') cur_row ++;
  else if(current == 'd') cur_col++;
  current = get_board_at(state,cur_row,cur_col);
  while(!is_head(current)){
    if(current == '<') cur_col --;
    else if(current == '>') cur_col ++;
    else if(current == '^') cur_row --;
    else if(current == 'v') cur_row ++;
    current = get_board_at(state,cur_row,cur_col);
  }
  state->snakes[snum].head_row = cur_row;
  state->snakes[snum].head_col = cur_col;

  return;
}

/* Task 6.2 */
game_state_t* initialize_snakes(game_state_t* state) {
  // TODO: Implement this function.
    unsigned int counter = 0;
    for(unsigned int i = 0; i < state->num_rows; i++){
        for(unsigned int j = 0; j < strlen(state->board[i]);j++){
            if(is_head(get_board_at(state,i,j))){
                    counter ++;
                }
            }
    }
    state->num_snakes = counter;
    state->snakes = malloc(counter * sizeof(snake_t));
    unsigned int snake_num = 0;
    for(unsigned int i = 0; i < state->num_rows; i++){
        for(unsigned int j = 0; j < strlen(state->board[i]);j++){
            if(is_tail(get_board_at(state,i,j))){
                    state->snakes[snake_num].tail_row = i;
                    state->snakes[snake_num].tail_col = j;
                    state->snakes[snake_num].live = true;
                    find_head(state,snake_num);
                    snake_num++;
                    if(snake_num == counter){
                        return state;
                    }
                }
            }
        }


  return state;
}
