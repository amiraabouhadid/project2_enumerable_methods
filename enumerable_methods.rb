module Enumerables
  def my_each
    return to_enum(:my_each) unless block_given?

    k = 0
    while k < to_a.length
      yield to_a[k]
      k += 1
    end
    self
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    k = 0
    while k < to_a.length
      yield(to_a[k], k)
      k += 1
    end
    self
  end

  def my_select
    return to_enum(:my_select) unless block_given?

    final = []
    num = [Hash, Range].member?(self.class) ? to_a.flatten : self
    k = 0
    count do
      final << num[k] if yield(num[k])
      k += 1
    end
    final
  end

  def my_inject(arg = nil, sym = nil)
    if (arg.is_a?(String) || arg.is_a?(Symbol)) && (!arg.nil? && sym.nil?)
      sym = arg
      arg = nil
    end
    if !block_given? && !sym.nil?
      my_each { |s| arg = arg.nil? ? s : arg.send(sym, s) }
    else
      my_each { |s| arg = arg.nil? ? s : yield(arg, s) }
    end
    arg
  end
end
