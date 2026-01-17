{
  config,
  pkgs,
  ...
}: {
  ############################
  # Yazi
  ############################
  programs.yazi = {
    enable = true;

    settings = {
      manager = {
        show_hidden = true; # 숨김파일 보기
        sort_by = "alphabetical"; # 이름순 정렬
        sort_dir_first = true; # 디렉토리 우선
        linemode = "size"; # 파일 크기 표시
      };

      preview = {
        tab_size = 2;
        max_width = 1000;
        max_height = 1000;
      };
    };
  };
}
