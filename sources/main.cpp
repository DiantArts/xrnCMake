#include <pch.hpp>
#include <fmt/format.h>

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
        return *m_value;
    }
    [[ nodiscard ]] operator Type&()
    {
        return *m_value;
    }

private:
    Type* m_value;
};

void func(int& val)
{
    ++val;
}

int main()
{
    int value{ 5 };
    OptionalReference<int> ref{ value };
    ::fmt::print("Does it has a value? {} ({})\n", ref.hasValue(), ref.getValue());
    func(ref);
    ::fmt::print("{}, it has the following value: {}\n", "It changed?", ref.getValue());
    return 0;
}
