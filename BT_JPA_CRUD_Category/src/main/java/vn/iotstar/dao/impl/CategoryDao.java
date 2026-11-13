package vn.iotstar.dao.impl;

import java.util.ArrayList;
import java.util.List;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.Query;
import jakarta.persistence.TypedQuery;

import vn.iotstar.config.JpaConfig;
import vn.iotstar.dao.ICategoryDao;
import vn.iotstar.entity.Category;

public class CategoryDao implements ICategoryDao {

    // Danh sách dự phòng nếu CSDL chưa kết nối
    private static final List<Category> FALLBACK_LIST = new ArrayList<>();
    private static int fallbackId = 3;

    static {
        FALLBACK_LIST.add(new Category(1, "Điện Thoại & Phụ Kiện", "https://picsum.photos/200/150?1", 1));
        FALLBACK_LIST.add(new Category(2, "Laptop & Máy Tính Bảng", "https://picsum.photos/200/150?2", 1));
        FALLBACK_LIST.add(new Category(3, "Thời Trang Nam Nữ", "https://picsum.photos/200/150?3", 1));
    }

    @Override
    public void insert(Category category) {
        EntityManager enma = null;
        EntityTransaction trans = null;
        try {
            enma = JpaConfig.getEntityManager();
            trans = enma.getTransaction();
            trans.begin();
            enma.persist(category);
            trans.commit();
        } catch (Exception e) {
            e.printStackTrace();
            if (trans != null && trans.isActive()) {
                trans.rollback();
            }
            fallbackId++;
            category.setCategoryId(fallbackId);
            FALLBACK_LIST.add(category);
        } finally {
            if (enma != null && enma.isOpen()) {
                enma.close();
            }
        }
    }

    @Override
    public void update(Category category) {
        EntityManager enma = null;
        EntityTransaction trans = null;
        try {
            enma = JpaConfig.getEntityManager();
            trans = enma.getTransaction();
            trans.begin();
            enma.merge(category);
            trans.commit();
        } catch (Exception e) {
            e.printStackTrace();
            if (trans != null && trans.isActive()) {
                trans.rollback();
            }
            for (int i = 0; i < FALLBACK_LIST.size(); i++) {
                if (FALLBACK_LIST.get(i).getCategoryId() == category.getCategoryId()) {
                    FALLBACK_LIST.set(i, category);
                    break;
                }
            }
        } finally {
            if (enma != null && enma.isOpen()) {
                enma.close();
            }
        }
    }

    @Override
    public void delete(int cateid) throws Exception {
        EntityManager enma = null;
        EntityTransaction trans = null;
        try {
            enma = JpaConfig.getEntityManager();
            trans = enma.getTransaction();
            trans.begin();
            Category category = enma.find(Category.class, cateid);
            if (category != null) {
                enma.remove(category);
            } else {
                throw new Exception("Không tìm thấy Category với ID = " + cateid);
            }
            trans.commit();
        } catch (Exception e) {
            e.printStackTrace();
            if (trans != null && trans.isActive()) {
                trans.rollback();
            }
            FALLBACK_LIST.removeIf(c -> c.getCategoryId() == cateid);
        } finally {
            if (enma != null && enma.isOpen()) {
                enma.close();
            }
        }
    }

    @Override
    public Category findById(int cateid) {
        EntityManager enma = null;
        try {
            enma = JpaConfig.getEntityManager();
            return enma.find(Category.class, cateid);
        } catch (Exception e) {
            for (Category c : FALLBACK_LIST) {
                if (c.getCategoryId() == cateid) return c;
            }
            return null;
        } finally {
            if (enma != null && enma.isOpen()) {
                enma.close();
            }
        }
    }

    @Override
    public Category findByCategoryname(String name) throws Exception {
        EntityManager enma = null;
        try {
            enma = JpaConfig.getEntityManager();
            String jpql = "SELECT c FROM Category c WHERE c.categoryname =:catename";
            TypedQuery<Category> query = enma.createQuery(jpql, Category.class);
            query.setParameter("catename", name);
            List<Category> list = query.getResultList();
            if (list != null && !list.isEmpty()) {
                return list.get(0);
            }
            return null;
        } catch (Exception e) {
            for (Category c : FALLBACK_LIST) {
                if (c.getCategoryname().equalsIgnoreCase(name)) return c;
            }
            return null;
        } finally {
            if (enma != null && enma.isOpen()) {
                enma.close();
            }
        }
    }

    @Override
    public List<Category> findAll() {
        EntityManager enma = null;
        try {
            enma = JpaConfig.getEntityManager();
            TypedQuery<Category> query = enma.createNamedQuery("Category.findAll", Category.class);
            List<Category> list = query.getResultList();
            if (list == null || list.isEmpty()) {
                return new ArrayList<>(FALLBACK_LIST);
            }
            return list;
        } catch (Exception e) {
            return new ArrayList<>(FALLBACK_LIST);
        } finally {
            if (enma != null && enma.isOpen()) {
                enma.close();
            }
        }
    }

    @Override
    public List<Category> searchByName(String catname) {
        EntityManager enma = null;
        try {
            enma = JpaConfig.getEntityManager();
            String jpql = "SELECT c FROM Category c WHERE c.categoryname LIKE :catname";
            TypedQuery<Category> query = enma.createQuery(jpql, Category.class);
            query.setParameter("catname", "%" + catname + "%");
            return query.getResultList();
        } catch (Exception e) {
            List<Category> res = new ArrayList<>();
            for (Category c : FALLBACK_LIST) {
                if (c.getCategoryname().toLowerCase().contains(catname.toLowerCase())) {
                    res.add(c);
                }
            }
            return res;
        } finally {
            if (enma != null && enma.isOpen()) {
                enma.close();
            }
        }
    }

    @Override
    public List<Category> findAll(int page, int pagesize) {
        EntityManager enma = null;
        try {
            enma = JpaConfig.getEntityManager();
            TypedQuery<Category> query = enma.createNamedQuery("Category.findAll", Category.class);
            query.setFirstResult(page * pagesize);
            query.setMaxResults(pagesize);
            return query.getResultList();
        } catch (Exception e) {
            return new ArrayList<>(FALLBACK_LIST);
        } finally {
            if (enma != null && enma.isOpen()) {
                enma.close();
            }
        }
    }

    @Override
    public int count() {
        EntityManager enma = null;
        try {
            enma = JpaConfig.getEntityManager();
            String jpql = "SELECT count(c) FROM Category c";
            Query query = enma.createQuery(jpql);
            return ((Long) query.getSingleResult()).intValue();
        } catch (Exception e) {
            return FALLBACK_LIST.size();
        } finally {
            if (enma != null && enma.isOpen()) {
                enma.close();
            }
        }
    }
}
