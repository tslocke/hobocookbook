class Gitorial
  # directory: point at the git repository
  # commit_link_base: the base for URL's to view the commit
  # patch_link_base: the base for URL's to download the patch
  def initialize(directory, commit_link_base="http://github.com/bryanlarsen/agility-gitorial/commit/", patch_link_base="/patches/agility/")
    @gitlogp = `cd #{directory}; git pack-refs --all ; git log --unified=5 --reverse gitorial-001^..HEAD`
    @tag_refs = File.read("#{directory}/.git/packed-refs")    
    @commit_link_base=commit_link_base
    @patch_link_base=patch_link_base
  end

  def tags
    @tags ||= begin
                tags = Hash.new { |hash, key| hash[key]=key.slice(0,6) }
                @tag_refs.slice(1..-1).each do |ref|
                  refs = ref.split
                  if File.dirname(refs[1])=="refs/tags"
                    tags[refs[0]] = File.basename(refs[1])
                  end
                end
                tags
              end
  end

  # returns a hash: filenames and contents
  def process
    filename = "index.markdown"
    markdowns = {filename => []}    
    state = :message
    message = ["\n"]
    patch = []
    commit = nil
    (@gitlogp.split("\n")+["DONE"]).each { |line|
      words=line.split
      if line.slice(0,1)==" " || words.length==0
        # commit messages start with 4 spaces, diff contents with 1 space
        if state==:message
          if words[0]=="OUTPUT_FILE:"
            filename = words[1]
            markdowns[filename] ||= []
          else
            message << "#{line.slice(4..-1)}"
          end
        else
          patch << "    #{line}" if state==:patch
        end
      elsif words[0]=="commit" or words[0]=="DONE"
        if !commit.nil?
          # replace the short description line with a named link
          shortlog = message[2]
          message[2] = "<a name='#{shortlog}'> </a>"
          markdowns[filename] += message.map {|l|
            if l=="SHOW_PATCH"
              (patch+["{: .diff}\n"]).join("\n")
            else
              l
            end
          }
          series = tags[commit].slice(-2..-1)
          markdowns[filename] << "\n#{tags[commit]}: [view on github](#{@commit_link_base}#{commit}), [download #{series}-#{shortlog}.patch](#{@patch_link_base}/#{series}-#{shortlog}.patch)\n{: .commit}\n"
        end
        
        message=["\n"]
        patch=[]

        commit = words[1]
        state = :message
      elsif ["Author:", "Date:", "new", "index", "---", "+++", '\\'].include?(words[0])
        # chomp
      elsif words[0]=="diff"
        state = :patch
        left = words[2].slice(2..-1)
        right = words[3].slice(2..-1)
        if left==right
          patch << "    ::: #{right}"
        else
          patch << "    ::: #{left} -> #{right}"
        end
      elsif words[0]=="@@"
        # git tries to put the function or class name after @@. This
        # works great for C diffs, but it only finds the class name in
        # Ruby, which is usually similar to the file name, Therefore
        # it's distracting cruft.  Toss it.
        patch << "    #{words.slice(0,4).join(" ")}"
      else
        message << "#{line.slice(4..-1)}" if state==:message
        patch << "    #{line}" if state==:patch       
      end
    }
    output = {}
    markdowns.each do |fn, markdown|
      output[fn] = markdown.join("\n")
      Rails.logger.info(output[fn]) if respond_to? :Rails
    end
    return output
  end
end

if $0 == __FILE__
  if ARGV.size < 2
    puts "Usage: ruby #{$0} commit_link_base patch_link_base <repository_directory> <output_directory>"
    puts "Example: ruby #{$0} http://github.com/bryanlarsen/agility-gitorial/commit/ /patches/agility/"
    exit 1
  end
  repository_directory=ARGV[2]
  repository_directory ||= '.'
  output_directory=ARGV[3]
  output_directory ||= '.'
  puts repository_directory
  puts output_directory
  
  Gitorial.new(repository_directory, ARGV[0], ARGV[1]).process.each {|fn, contents|
    f=open("#{output_directory}/#{fn}", "w")
    f.write(contents)
    f.close   # need explicit close so Rakefiles work
  }
end
