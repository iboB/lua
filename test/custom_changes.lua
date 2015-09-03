-- function calls with all literal arguments without parentheses
print 1
print true
print false

-- || anonymous function

foo = |func|
    func()
end

foo ||
    print "hello"
end
