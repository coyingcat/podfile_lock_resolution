
precedencegroup RunesApplicativeSequencePrecedence {
    associativity: left
    higherThan: LogicalConjunctionPrecedence
    lowerThan: NilCoalescingPrecedence
}


/**
 sequence actions, discarding right (value of the second argument)
 Expected function type: `f a -> f b -> f a`
 Haskell `infixl 4`
 */
infix operator <* : RunesApplicativeSequencePrecedence

/**
 sequence actions, discarding left (value of the first argument)
 Expected function type: `f a -> f b -> f b`
 Haskell `infixl 4`
 */
infix operator *> : RunesApplicativeSequencePrecedence

/**
 map a function over a value with context and flatten the result
 Expected function type: `(a -> m b) -> m a -> m b`
 Haskell `infixr 1`
 */
