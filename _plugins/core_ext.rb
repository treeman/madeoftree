class String
    def slugize
        self.downcase.gsub(/[\s\.]/, '_').gsub(/[^\w\d\-]/, '')
    end
end

