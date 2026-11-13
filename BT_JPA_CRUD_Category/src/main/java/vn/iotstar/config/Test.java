package vn.iotstar.config;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import vn.iotstar.entity.Category;
import vn.iotstar.entity.Video;

public class Test {
    public static void main(String[] args) {
        System.out.println("=== BAT DAU KIEM TRA KET NOI VA KHOI TAO BANG VOI JPA ===");
        EntityManager enma = JpaConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();

        Category cate = new Category();
        cate.setCategoryname("Iphone 16 Pro Max");
        cate.setImages("iphone16.jpg");
        cate.setStatus(1);

        Video video = new Video();
        video.setVideoId("v01");
        video.setTitle("Review Iphone 16");
        video.setCategory(cate);

        try {
            trans.begin();
            enma.persist(cate);
            enma.persist(video);
            trans.commit();
            System.out.println(">>> THANH CONG: Da them Category va Video vao CSDL thanh cong!");
        } catch (Exception e) {
            e.printStackTrace();
            if (trans.isActive()) {
                trans.rollback();
            }
        } finally {
            enma.close();
        }
    }
}
