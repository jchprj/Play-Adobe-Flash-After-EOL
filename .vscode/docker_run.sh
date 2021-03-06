export image_name=play-adobe-flash-after-eol
export image_tag=latest

echo ansible-playbook .vscode/run.yml --tags play-adobe-flash-after-eol -e image=local/$image_name:$image_tag
ansible-playbook .vscode/run.yml --tags play-adobe-flash-after-eol -e image=local/$image_name:$image_tag
