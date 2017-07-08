# Functor

```Haskell
class Functor f where
  fmap :: (a -> b) -> f a -> f b
```

为了让任意数据结构能够对任意函数使用`map`（映射）操作，必须要让`map`认识怎么操作这个数据结构，`fmap`所做的工作就是告诉`map`如何解包数据结构，进行函数操作后再如何封装。

而C++里面的Functor制作出来的函数对应的是Haskell里面的Partial Applied Function（半参数化函数），是两个东西，C++里面类似Haskell的Functor的东西是Template。

# Applicative Functor

```Haskell
class Functor f where -- 类Functor接受一个参数f，这个f是一个类型构造器（比如Maybe)，它的
                      -- 类型是* -> *
  fmap :: (a -> b) -> f a -> f b -- 输入一个接受输入a类型并产生b类型的函数g，和一个接受f
                                 -- 构造、a类型参数，输出一个f构造，b类型的东西，为什么f
                                 -- 是一个类型，a也是一个类型呢，例如Maybe,Maybe是一个类
                                 -- 型，同时在定义data的时候它放在右边也是一个Constructor
                                 -- 比如Maybe Int，所以输入和输出都要有外包装类型的Con
                                 -- structor和里面的实际类型

class Functor f => Applicative f where
  pure  :: a -> f a -- 如果输入一个a类型，就用f的Constructor包装后返回
  (<*>) :: f (a -> b) -> f a -> f b -- 输入一个f的Constructor、a类型产生b类型的函数，
                                    -- 这是一个Functor。
                                    -- 输入一个f a，这和Functor的第二个参数一样
                                    -- 输出一个f b，这和Functor的输出一样
```

Applicative Functor里面还定义了一个操作符<$>，表示fmap

`fmap2`称为`liftA2`

```Hasekll
liftA2 :: Applicative f => (a -> b -> c) -> f a -> f b -> f c
liftA2 h fa fb = (h `fmap` fa) <*> fb
```

Functor是在实类型上下文中从type constructor中提取内容的函数，而`liftA2`是从Functor上下文中提取函数的函数

因为Haskell实际上每次只接受一个参数，然后返回一个函数（currying），所以为了完成`Int -> Int -> String`转为`[Int] -> [Int] -> [String]`或者`Maybe Int -> Maybe Int -> Maybe String`之类的操作，`fmap`在接受`Int`后返回的是`[Int] -> [String]`或者`Maybe Int -> Maybe String`，而`fmap`是无法继续接受`[Int]`或者`Maybe Int`作为输入，然后产生`[String]`或者`Maybe String`的，所以需要`(<*>)`的帮忙。

# Monad

```Haskell
class Monad m where
  return :: a -> m a

  (>>=) :: m a -> (a -> m b) -> m b

  (>>)  :: m a -> m b -> m b
  m1 >> m2 = m1 >>= \_ -> m2
```

Functor只把函数适配，但是不关心每一个函数的返回值或者成功状态，Monad关心这些值并决定下一步怎么做。
