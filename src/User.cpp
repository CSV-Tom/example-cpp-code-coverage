
#include "include/User.hpp"

User::User(std::string prename, std::string surname) : mPrename(std::move(prename)), mSurname(std::move(surname)) {
	// do nothing at moment
}

User::~User() = default;

std::string User::getPrename() { return mPrename; }
std::string User::getSurname() { return mSurname; }
