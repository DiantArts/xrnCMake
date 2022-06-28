#include <pch.hpp>
#include <factorial.hpp>



[[ gnu::noinline ]] [[ nodiscard ]] auto ::ctsb::factorial(
    const ::std::uint8_t n
) -> ::std::uint64_t
{
    return n == 0 || n == 1 ? 1 : static_cast<::std::uint64_t>(n) * factorial(n - 1);
}

