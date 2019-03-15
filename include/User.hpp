#ifndef INCLUDE_USER_HPP
#define INCLUDE_USER_HPP

#include <string>

class User {
public:
    User(std::string prename, std::string surname);
    ~User();
    std::string getPrename();
    std::string getSurname();
private:
    std::string mPrename;
    std::string mSurname;
};

#endif
