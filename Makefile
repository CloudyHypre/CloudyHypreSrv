#make cloudy_server

#vars

HYPREBIN=bin
HYPREOBJ=obj
HYPRESRC=src

BIN=spring-server/bin
OBJ=spring-server/obj
SRC=spring-server/src

OBJ_MODS=spring-server/obj/modules
SRC_MODS=spring-server/src/modules

OBJ_EX=spring-server/obj/example
SRC_EX=spring-server/src/example

CC ?= gcc
CFLAGS ?= -Wextra -Wall -iquote$(SRC)
CFLAGSHYPRE ?= -I$(SRC) -Wextra -Wall -iquote$(HYPRESRC)

SERVERFLAGS = -DIS_SERVER=1 -DIS_CLIENT=0
CLIENTFLAGS = -DIS_SERVER=0 -DIS_CLIENT=1

.PHONY: all clean

all: cloudy_server

#executables

cloudy_server: $(OBJ_MODS)/termflag.o $(OBJ_MODS)/mainsocket.o $(OBJ_MODS)/inputpayload.o $(OBJ_MODS)/inputcommand.o $(OBJ_MODS)/nextperiodic.o $(OBJ_MODS)/sockettime.o $(OBJ_MODS)/readlist.o $(OBJ_MODS)/socketlist.o $(OBJ_MODS)/disconnectfunction.o $(OBJ_MODS)/connectfunction.o $(OBJ_MODS)/command.o $(OBJ_MODS)/periodic.o $(OBJ_MODS)/network.o $(OBJ_MODS)/log.o $(OBJ_MODS)/component.o $(OBJ_MODS)/main_server.o $(HYPREOBJ)/server.o | $(HYPREBIN)
	$(CC) $(CFLAGSHYPRE) -o $(HYPREBIN)/$@ $^
	
#objects
	
$(OBJ_MODS)/main_server.o: $(SRC_MODS)/main.c | $(OBJ_MODS)
	$(CC) $(CFLAGS) $(SERVERFLAGS) -o $@ -c $<
	
$(OBJ_MODS)/%.o: $(SRC_MODS)/%.c | $(OBJ_MODS)
	$(CC) $(CFLAGS) -o $@ -c $<

$(OBJ_EX)/%.o: $(SRC_EX)/%.c | $(OBJ_EX)
	$(CC) $(CFLAGS) -o $@ -c $<

$(HYPREOBJ)/%.o: $(HYPRESRC)/%.c | $(HYPREOBJ)
	$(CC) $(CFLAGSHYPRE) -o $@ -c $<
	
#directories
	
$(OBJ_MODS): $(OBJ)
	mkdir -p $(OBJ_MODS)
	
$(OBJ_EX): $(OBJ)
	mkdir -p $(OBJ_EX)

$(OBJ):
	mkdir -p $(OBJ)
	
$(HYPREBIN):
	mkdir -p $(HYPREBIN)

$(HYPREOBJ):
	mkdir -p $(HYPREOBJ)

#phony
	
clean:
	rm -rf $(HYPREBIN)
	rm -rf $(HYPREOBJ)
