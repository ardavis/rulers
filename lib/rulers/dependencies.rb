class Object
  def self.const_missing(c)
    return nil if @calling_const_missing

    @calling_const_missing = true
    file = Rulers.to_underscore(c.to_s)
    require file

    klass = Object.const_get(c)
    @calling_const_missing = false

    if klass.nil?
      raise StandardError, "Expected #{file} to define #{c} but it did not."
    end

    klass
  end
end