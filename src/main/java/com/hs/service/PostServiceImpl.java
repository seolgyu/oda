package com.hs.service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import com.hs.mapper.PostMapper;
import com.hs.model.CommentDTO;
import com.hs.model.FileAtDTO;
import com.hs.model.PostDTO;
import com.hs.model.ReportDTO;
import com.hs.mybatis.support.MapperContainer;

public class PostServiceImpl implements PostService {

	private PostMapper mapper = MapperContainer.get(PostMapper.class);
	private CommunityService communityService = new CommunityServiceImpl();

	@Override
	public void insertPost(PostDTO dto) throws Exception {
		try {

			mapper.insertPost(dto);

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
			// 1. 글 내용 수정
			mapper.updatePost(dto);

			// 2. 새로운 파일이 있다면 추가 저장
			List<FileAtDTO> newFiles = dto.getFileList();
			if (newFiles != null && !newFiles.isEmpty()) {

				// 기존 파일 중 가장 큰 순서 번호를 가져옴 (순서 유지를 위해)
				// (Mapper에 maxFileOrder 쿼리가 필요하지만, 없으면 목록 개수로 추정하거나 쿼리 추가 필요)
				// 여기서는 간단히 현재 등록된 파일 리스트를 가져와서 사이즈를 잽니다.
				List<FileAtDTO> oldFiles = mapper.listFileAt(dto.getPostId());
				int startOrder = 0;
				if (oldFiles != null && !oldFiles.isEmpty()) {
					startOrder = oldFiles.get(oldFiles.size() - 1).getFileOrder() + 1;
				}

				for (FileAtDTO fileDto : newFiles) {
					fileDto.setPostId(dto.getPostId());
					fileDto.setFileOrder(startOrder++); // 순서 이어붙이기
					mapper.insertFileAt(fileDto);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void deletePost(long postId) throws Exception {
		try {
			// PostMapper.xml에 update is_deleted = '1' 쿼리가 있는지 확인 필요
			// 만약 없다면 deletePost 쿼리를 xml에 추가해야 함.
			// 보내주신 xml에는 updatePost만 있고 deletePost(id)는 없습니다. 추가해야 합니다.

			// (임시) DTO를 만들어 updatePost 재활용 (is_deleted만 '1'로)
			// 하지만 정석은 Mapper에 deletePost 쿼리를 만드는 것입니다.
			// 아래는 Mapper에 deletePost가 있다고 가정하고 호출합니다.
			mapper.deletePost(postId);

		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public PostDTO findById(long postId) {
		PostDTO dto = null;

		try {

			mapper.updateHitCount(postId);

			dto = mapper.findById(postId);

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

			int check = mapper.checkPostLiked(map);

			if (check > 0) {
				mapper.deletePostLike(map);
				isLiked = false;
			} else {
				mapper.insertPostLike(map);
				isLiked = true;
			}

			mapper.updatePostLikeCount(postId);

		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return isLiked;
	}

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
			mapper.updatePostCommentCount(dto.getPostId());
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
			map.put("userNum", currentUserNum);

			list = mapper.listComment(map);

			for (CommentDTO dto : list) {

				dto.setContent(dto.getContent().replaceAll("\n", "<br>"));

				String timeMsg = com.hs.util.DateUtil.calculateTimeAgo(dto.getCreatedDate());
				dto.setTimeAgo(timeMsg);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public void deleteComment(long commentId, long userNum) throws Exception {
		try {
			long postId = mapper.getPostIdByCommentId(commentId);
			
			mapper.deleteComment(commentId);
			
			mapper.updatePostCommentCount(postId);
			
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

			int check = mapper.checkCommentLiked(map);

			if (check > 0) {

				mapper.deleteCommentLike(map);
				isLiked = false;
			} else {

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

			int count = mapper.checkPostLiked(map);
			if (count > 0) {
				result = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public void updateComment(CommentDTO dto) throws Exception {
		try {
			mapper.updateComment(dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	@Override
    public void deleteFileAt(long fileAtId) throws Exception {
        try {
            // (선택) 실제 파일이나 클라우드에서 삭제하려면 여기서 먼저 조회 후 처리
            mapper.deleteFileAt(fileAtId);
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

	@Override
	public List<PostDTO> listUserPost(Map<String, Object> map) throws SQLException {
		List<PostDTO> list = null;
		try {
			list = mapper.listUserPost(map);
			for(PostDTO item : list) {
				item.setLikedByUser(isLiked(item.getPostId(), (Long)map.get("loginUserNum")));
				List<FileAtDTO> files = mapper.listFileAt(item.getPostId());
				item.setFileList(files);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	@Override
	public List<PostDTO> listUserRepost(Map<String, Object> map) throws SQLException {
		List<PostDTO> list = null;
		try {
			list = mapper.listUserRepost(map);
			for(PostDTO item : list) {
				item.setLikedByUser(isLiked(item.getPostId(), (Long)map.get("loginUserNum")));
				List<FileAtDTO> files = mapper.listFileAt(item.getPostId());
				item.setFileList(files);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	@Override
	public void insertReport(ReportDTO dto) throws Exception {
	    try {
	        mapper.insertReport(dto);
	        
	        long postId = Long.parseLong(dto.getReportContent());
	        mapper.updatePostReportCount(postId);
	        
	    } catch (Exception e) {
	        throw e;
	    }
	}
	
	@Override
	public PostDTO findTempPost(long userNum) {
	    PostDTO dto = null;
	    try {
	        dto = mapper.findTempPost(userNum);
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return dto;
	}

	@Override
	public void saveTempPost(PostDTO dto) throws Exception {
	    try {
	        PostDTO tempDto = mapper.findTempPost(dto.getUserNum());

	        if (tempDto != null) {
	          
	            dto.setPostId(tempDto.getPostId()); 
	            mapper.updatePost(dto); 
	        } else {
	           
	            mapper.insertPost(dto);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	        throw e;
	    }
	}

	@Override
	public List<PostDTO> listCommunityPost(Map<String, Object> map) {
	    List<PostDTO> list = new ArrayList<>(); 
	    try {
	    
	        list = mapper.listCommunityPost(map);
	        
	        if (list == null) return new ArrayList<>();

	        for(PostDTO item : list) {
	         
	            Object userNumObj = map.get("user_num");
	            long loginUserNum = 0L;
	            
	            if (userNumObj != null) {
	                try {
	                    loginUserNum = Long.parseLong(userNumObj.toString());
	                } catch (Exception e) {
	                    loginUserNum = 0L; 
	                }
	            }

	            if (loginUserNum != 0) {
	                item.setLikedByUser(isLiked(item.getPostId(), loginUserNum));
	            }
	
	            List<FileAtDTO> files = mapper.listFileAt(item.getPostId());
	            item.setFileList(files != null ? files : new ArrayList<>());
	        }
	    } catch (Exception e) {
	        
	        System.out.println("로그: listCommunityPost에서 에러 발생!!!");
	        e.printStackTrace(); 
	    }
	    return list;
	}
	
	@Override
    public boolean insertPostSave(long postId, long userNum) throws Exception {
        boolean result = false;
        try {
            Map<String, Object> map = new HashMap<>();
            map.put("postId", postId);
            map.put("userNum", userNum);
         
            int count = mapper.checkPostSaved(map);

            if (count == 0) {
               
                mapper.insertPostSave(map);
                result = true; 
            } else {
               
                mapper.deletePostSave(map);
                result = false; 
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
        return result;
    }

    @Override
    public boolean insertPostRepost(long postId, long userNum) throws Exception {
        boolean result = false;
        try {
            Map<String, Object> map = new HashMap<>();
            map.put("postId", postId);
            map.put("userNum", userNum);

            int count = mapper.checkPostReposted(map);

            if (count == 0) {
               
                mapper.insertPostRepost(map);
                result = true; 
            } else {
               
                mapper.deletePostRepost(map);
                result = false; 
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
        return result;
    }
    
    @Override
    public List<PostDTO> listSavedPost(Map<String, Object> map) {
        return mapper.listSavedPost(map);
    }

    @Override
    public List<PostDTO> listRepostedPost(Map<String, Object> map) {
        return mapper.listRepostedPost(map);
    }

	@Override
	public Long getPostAuthorNum(Long postId) throws Exception {
		Long userNum = null;
		try {
			userNum = mapper.getPostAuthorNum(postId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return userNum;
	}

	@Override
	public Long getCommentWriterNum(Long commentId) throws Exception {
		Long userNum = null;
		try {
			userNum = mapper.getCommentWriterNum(commentId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return userNum;
	}

	@Override
	public CommentDTO getCommentInfo(Long commentId) throws Exception {
		CommentDTO dto = null;
		try {
			dto = mapper.getCommentInfo(commentId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public Long getComId(Long postId) throws Exception {
		Long communityId = null;
		try {
			communityId = mapper.getComId(postId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return communityId;
	}

}