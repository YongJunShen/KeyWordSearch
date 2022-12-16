require 'rubygems'

class FileUtil 
	def initialize(filePath, keyword)
		@linenum = 0
		@filePath = filePath
		@keyword = keyword
	end

	def fileExist(path) 
		if !File.exist? path
			return false
		else 
			return true
		end
	end

	def match() 
		unless @filePath
			puts "警告：入参不能为空，请输入需要匹配的目录"
			return
		end

		unless @keyword
			puts "警告：搜索关键字不能为空"
			return
		end

		if !fileExist(@filePath)
			puts "警告：当前目录不存在"
			return
		end

		if File.directory?(@filePath)
			puts  "#{@filePath}"
			get_file_list(@filePath)
		else
			puts "警告：当前目录不是文件夹"	
			analyse(@filePath)
		end
		
	end	

	def analyse(filePath)
		
		File.open(filePath, "r") do |file| 

			file.each_line { |line| 
				@linenum = @linenum + 1
				if line.include? @keyword
					puts "文件路径为#{filePath}，匹配到第#{@linenum}行，具体内容为#{line.strip} "
				end
			}
	   end
	end

	def get_file_list(path) 
	  Dir.entries(path).each do |sub|       
	    if sub != '.' && sub != '..'  
	      if File.directory?("#{path}/#{sub}")  
	        get_file_list("#{path}/#{sub}")  
	      else  
	        analyse("#{path}/#{sub}")
	      end  
	    end  
	  end  
	end  

end

filePath = ARGV[0]
keyword = ARGV[1]
fileUtil =  FileUtil.new(filePath, keyword)
fileUtil.match()