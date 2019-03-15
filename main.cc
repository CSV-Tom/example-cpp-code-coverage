#include <iostream>

#include "include/EUserRole.hpp"
#include "include/User.hpp"

int main(int argc, char** argv) {

	User user("Tom", "Christiane");
	return static_cast<int>(EUserRole::Admin);
}
