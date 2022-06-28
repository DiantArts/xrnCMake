#pragma once

namespace ctsb {



class CoverageSlave {
public:
    CoverageSlave(
        int value
    )
    {
        if (value % 2) {
            m_value += value;
        }
    }

private:
    int m_value{ 1 };
};



// runtime factorial
[[ nodiscard ]] auto factorial(
    const ::std::uint8_t n
) -> ::std::uint64_t;



// compiletime factorial
template <
    ::std::uint8_t n
> [[ nodiscard ]] consteval auto constevalFactorial()
    -> ::std::uint64_t
{
    if constexpr (n < 2) {
        return 1;
    } else {
        return static_cast<::std::uint64_t>(n) * constevalFactorial<n - 1>();
    }
}



} // namespace ctsb
