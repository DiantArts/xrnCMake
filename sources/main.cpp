#include <pch.hpp>
#include <fmt/format.h>
#include <SFML/System/Time.hpp>

template <
    typename Type
> class OptionalReference {
public:
    OptionalReference(Type* value = nullptr)
        : m_value{ value }
    {}
    OptionalReference(Type& value)
        : m_value{ &value }
    {}

    [[ nodiscard ]] auto hasValue() const
        -> bool
    {
        return !!m_value;
    }
    [[ nodiscard ]] auto get()
        -> Type&
    {
        return m_value;
    }
    [[ nodiscard ]] auto getValue()
        -> Type&
    {
        return m_value;
    }
    [[ nodiscard ]] operator Type&()
    {
        return *m_value;
    }

private:
    Type* m_value;
};

void func(int val)
{
    ::std::cout << val << ::std::endl;
}

int main()
{
    int value{ 5 };
    OptionalReference<int> ref{ value };
    ::std::cout << ref.hasValue() << ::std::endl;
    func(ref);
    ::std::cout << ref << ::std::endl;
    ::fmt::print("{}\n", "hello?");
    return 0;
}
