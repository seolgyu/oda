package com.hs.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.hs.mapper.PostMapper;
import com.hs.model.CommentDTO;
import com.hs.model.FileAtDTO;
import com.hs.model.PostDTO;
import com.hs.mybatis.support.MapperContainer;

public class PostServiceImpl implements PostService {

	// MyBatis 매퍼 객체 가져오기
	private PostMapper mapper = MapperContainer.get(PostMapper.class);

	@Override
	public void insertPost(PostDTO dto) throws Exception {
		try {
			// 1. 게시글 저장 (게시글 번호 생성)
			mapper.insertPost(dto);

			// 2. 파일이 있다면 파일 테이블에 저장
			List<FileAtDTO> files = dto.getFileList();
			if (files != null && !files.isEmpty()) {
				for (FileAtDTO fileDto : files) {
					fileDto.setPostId(dto.getPostId());
					mapper.insertFileAt(fileDto);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void updatePost(PostDTO dto) throws Exception {
		try {
			mapper.updatePost(dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public PostDTO findById(long postId) {
		PostDTO dto = null;

		try {
			// 1. 조회수 증가 (상세 보기 시에만 증가)
			mapper.updateHitCount(postId);

			// 2. 게시글 상세 정보 가져오기
			dto = mapper.findById(postId);

			// 3. 첨부파일 리스트 가져오기 및 DTO에 설정
			if (dto != null) {
				List<FileAtDTO> files = mapper.listFileAt(postId);
				dto.setFileList(files);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return dto;
	}

	@Override
	public List<PostDTO> listPost() {
		List<PostDTO> list = null;
		try {
			list = mapper.listPost();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public List<PostDTO> listPostMain(Map<String, Object> map) {
		List<PostDTO> list = null;
		try {
			list = mapper.listPostMain(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public boolean insertPostLike(long postId, long userNum) throws Exception {
		boolean isLiked = false;
		try {
			Map<String, Object> map = new HashMap<>();
			map.put("postId", postId);
			map.put("userNum", userNum);

			// 1. 이미 좋아요를 눌렀는지 확인
			int check = mapper.checkPostLiked(map);

			if (check > 0) {
				// 2. 이미 눌렀으면 -> 좋아요 취소 (삭제)
				mapper.deletePostLike(map);
				isLiked = false;
			} else {
				// 3. 안 눌렀으면 -> 좋아요 추가
				mapper.insertPostLike(map);
				isLiked = true;
			}

			// 4. 게시글 테이블(POSTS)의 좋아요 개수(LIKE_COUNT) 동기화 (성능 최적화)
			mapper.updatePostLikeCount(postId);

		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return isLiked;
	}

	// [2] 좋아요 개수 조회 (Controller 오류 해결용)
	@Override
	public int countPostLike(long postId) {
		int count = 0;
		try {
			count = mapper.countPostLike(postId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return count;
	}

	@Override
	public void insertComment(CommentDTO dto) throws Exception {
		try {
			mapper.insertComment(dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public List<CommentDTO> listComment(long postId, long currentUserNum) {
		List<CommentDTO> list = null;
		try {
			Map<String, Object> map = new HashMap<>();
			map.put("postId", postId);
			map.put("userNum", currentUserNum); // 로그인 안 했으면 0이 들어옴

			list = mapper.listComment(map);

			// (선택) 엔터키 처리: content 안의 \n을 <br>로 변환
			for (CommentDTO dto : list) {
				dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public void deleteComment(long commentId) throws Exception {
		try {
			mapper.deleteComment(commentId);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public boolean insertCommentLike(long commentId, long userNum) throws Exception {
	    boolean isLiked = false;
	    try {
	        Map<String, Object> map = new HashMap<>();
	        map.put("commentId", commentId);
	        map.put("userNum", userNum);

	        // 1. 이미 좋아요를 눌렀는지 확인
	        int check = mapper.checkCommentLiked(map);

	        if (check > 0) {
	            // 2. 이미 눌렀으면 -> 좋아요 취소
	            mapper.deleteCommentLike(map);
	            isLiked = false;
	        } else {
	            // 3. 안 눌렀으면 -> 좋아요 추가
	            mapper.insertCommentLike(map);
	            isLiked = true;
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	        throw e;
	    }
	    return isLiked;
	}
	
	@Override
	public int countCommentLike(long commentId) throws Exception {
	    return mapper.countCommentLike(commentId);
	}
	
	@Override
    public boolean isLiked(long postId, long userNum) {
        boolean result = false;
        try {
            Map<String, Object> map = new HashMap<>();
            map.put("postId", postId);
            map.put("userNum", userNum);
            
            // Mapper에 이미 만들어둔 checkPostLiked 활용
            int count = mapper.checkPostLiked(map);
            if(count > 0) {
                result = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

}