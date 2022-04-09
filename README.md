<h1 align="center">
	ft_printf
</h1>

<p align="center">
	<img src="https://user-images.githubusercontent.com/91064070/147373424-c4e3c444-0747-4a9e-b333-7d3a207e8c45.png?raw=true" alt="Sublime's custom image"/>
</p>

## Result

/![](result.png)

## How It Works

We use a [variadic function](https://en.cppreference.com/w/c/language/variadic) which is a function that can take a variable number of arguments.

First, the function [`ft_printf()`](ft_printf.c) has to be declared with a string (`*fmt`) as its first parameter and three dots (`...`) as its second parameter. The latter indicates that the function allows to accept any number of extra arguments of any type.

```c
int	ft_printf(const char *fmt, ...);
```

Next, we are going to declare a macro `va_list` which is a pointer to a list of variable arguments. It also holds the information needed by the macros `va_start`, `va_arg`, and `va_end` which we are going to use afterwards.

Then, we use the macro `va_start(<va_list>, fmt)` which initializes `va_list` to point to the first argument after the argument specified. It needs two parameters, the name of `va_list` and the maximum number of arguments that we are going to pass to [`ft_printf()`](ft_printf.c) that is, in the case of [`ft_printf()`](ft_printf.c), potentially the whole `*fmt`.

```c
int	ft_printf(const char *fmt, ...)
{
	va_list args;
	va_start(args, fmt);
}
```

Now, we use `va_arg(<va_list>, <type>)` which fetches the next argument out of the list. You must specify the type of the argument so that `va_arg` knows how many bytes to extract.

Finally, we use `va_end(<va_list>)` to end traversal of the variadic function arguments and to release any memory held by the `va_list` data structure.

We should have for example:

```c
int	ft_printf(const char *fmt, ...)
{
	va_list args;
	va_start(args, fmt);
	va_arg(args, unsigned int);
	va_end(args);
}
```

In the case of [`ft_printf()`](ft_printf.c), the type of the arguments can change, so we need to scan `*fmt` for the `%` character, then check the following character and execute the function matching the type of conversion. Below is the table of input conversions.

|Specifier(s)|Function|Output to [stdout](https://en.wikipedia.org/wiki/Standard_streams#Standard_output_(stdout))|
|---|---|---|
|`%c`|`write()`|Prints a single character.|
|`%s`|`ft_putstr()`|Prints a string of characters.|
|`%p`|`ft_puthex()`|Prints a pointer address in hexadecimal (with "0x" prefix).|
|`%d`, `%i`|`ft_putnbr()`|Prints a signed decimal integer.|
|`%u`|`ft_putnbr_len()`|Prints an unsigned decimal integer.|
|`%x`, `%X`|`ft_puthex()`|Prints an unsigned hexadecimal integer (x: lowercase, X: uppercase).|
|`%%`|`write()`|Prints a percent sign.|

## Usage

Clone this repository and access its folder:

```shell
git clone https://github.com/ddupont06/42-ft_printf.git && cd 42-ft_printf
```

To compile the `libftprintf.a` program (cf. [`subjet`](ft_printf.pdf)) run:

```shell
make
```

Create a main file:

```shell
touch main.c
```

Below is an example of main file:

```C
#include <stdio.h>
#include <limits.h>

int	ft_printf(const char *fmt, ...);

int	main(void)
{
	int	ret1;
	int	ret2;

	// %c
	printf("\nc:\n");
	ret1 = printf("--%c--\n", 'c');
	ret2 = ft_printf("--%c--\n", 'c');
	printf("printf : %i || ft_printf : %i\n\n", ret1, ret2);

	// %s
	printf("s:\n");
	ret1 = printf("%s\n", "Hello world !");
	ret2 = ft_printf("%s\n", "Hello world !");
	printf("printf : %i || ft_printf : %i\n\n", ret1, ret2);

	// %p
	printf("p:\n");
	char	*str = "test";
	ret1 = printf("Address: %p\n", str);
	ret2 = ft_printf("Address: %p\n", str);
	printf("printf : %i || ft_printf : %i\n\n", ret1, ret2);
	ret1 = printf("null: %p\n", NULL);
	ret2 = ft_printf("null: %p\n", NULL);
	printf("printf : %i || ft_printf : %i\n\n", ret1, ret2);

	// %d, %i
	printf("d, i:\n");
	ret1 = printf("INT_MIN: %i\n", INT_MIN);
	ret2 = ft_printf("INT_MIN: %i\n", INT_MIN);
	printf("printf : %i || ft_printf : %i\n\n", ret1, ret2);
	ret1 = printf("INT_MAX: %i\n", INT_MAX);
	ret2 = ft_printf("INT_MAX: %i\n", INT_MAX);
	printf("printf : %i || ft_printf : %i\n\n", ret1, ret2);

	// %u
	printf("u:\n");
	ret1 = printf("uint max: %u\n", UINT_MAX);
	ret2 = ft_printf("uint max: %u\n", UINT_MAX);
	printf("printf : %i || ft_printf : %i\n\n", ret1, ret2);

	// %x, %X
	printf("x, X:\n");
	ret1 = printf("Lowercase: %x, Uppercase: %X\n", INT_MIN, INT_MIN);
	ret2 = ft_printf("Lowercase: %x, Uppercase: %X\n", INT_MIN, INT_MIN);
	printf("printf : %i || ft_printf : %i\n\n", ret1, ret2);
	ret1 = printf("Lowercase: %x, Uppercase: %X\n", INT_MAX, INT_MAX);
	ret2 = ft_printf("Lowercase: %x, Uppercase: %X\n", INT_MAX, INT_MAX);
	printf("printf : %i || ft_printf : %i\n\n", ret1, ret2);

	// %%
	printf("%%:\n");
	ret1 = printf("42%%\n");
	ret2 = ft_printf("42%%\n");
	printf("printf : %i || ft_printf : %i\n\n", ret1, ret2);
}

```

To use [`ft_printf()`](ft_printf.c) in your code, include its prototype in your C projects:

```C
int	ft_printf(const char *fmt, ...);
```

And compile your C project with the `ft_printf.c` or `libftprintf.a` file:

```shell
gcc <projet.c> ft_printf.c -o <project_name>
gcc <projet.c> libftprintf.a -o <project_name>
```

Note that the outputs may vary depending on your OS. For example, when a NULL pointer `%p` is sent to [`ft_printf()`](ft_printf.c) the return value is `(nil)` on Linux and `0x0` on MacOS.


To delete all the objet `*.o` files after compilation run:

```shell
make clean
```

To delete all the objet `*.o` files and the `libftprintf.a` file after compilation run:

```shell
make fclean
```
