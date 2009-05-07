class Gitorial
  # initialize with `git log -p --reverse`, `.git/packed-refs`
  def initialize(gitlogp, commit_link_base="http://github.com/bryanlarsen/agility-gitorial/commit/", patch_link_base="/patches/agility/", tag_refs="")
    @gitlogp=gitlogp
    @commit_link_base=commit_link_base
    @tag_refs=tag_refs
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

  def to_s
    markdown = []
    state = :message
    message = ["\n"]
    patch = []
    commit = nil
    (@gitlogp.split("\n")+["DONE"]).each { |line|
      words=line.split
      if line.slice(0,1)==" " || words.length==0
        message << "#{line.slice(4..-1)}" if state==:message
        patch << "    #{line}" if state==:patch
      elsif words[0]=="commit" or words[0]=="DONE"
        if !commit.nil?
          # replace the short description line with a named link
          shortlog = message[2]
          message[2] = "<a name='#{shortlog}'> </a>"
          markdown += message.map {|l|
            if l=="SHOW_PATCH"
              (patch+["{: .diff}\n"]).join("\n")
            else
              l
            end
          }
          series = tags[commit].slice(-2..-1)
          markdown << "\n#{tags[commit]}: [view on github](#{@commit_link_base}#{commit}), [download #{series}-#{shortlog}.patch](#{@patch_link_base}/#{series}-#{shortlog}.patch)\n{: .commit}\n"
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
    Rails.logger.info(markdown.join("\n"))
    markdown.join("\n")
  end
end
