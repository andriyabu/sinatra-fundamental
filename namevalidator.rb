class NameValidator
    def initialize(name, names)
        @name = name.to_s
        @names = names
    end

    def valid?
        validate
        @message.nil?
    end

    def message
        @message
    end      
    
    private

    def validate
        if @name.empty?
          @message = "You need to enter message"
        elsif @message.include?(@name)
            @message = "#{@name} is already included in file list"
        end
    end
end