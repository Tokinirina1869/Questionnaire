package com.monapp.repository;

import java.util.List;

import com.monapp.model.Admin;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import jakarta.persistence.PersistenceContext;

@Stateless
public class AdminRepository {

    @PersistenceContext
    private EntityManager em;

    public void save(Admin admin) {
        em.persist(admin);
    }

    public List<Admin> findAll(){
        return em.createQuery("SELECT a FROM Admin a", Admin.class).getResultList();
    }

    public Admin findByEmail(String email) {
        try {
            return em.createQuery("SELECT a FROM Admin a WHERE a.emailAdmin = :email", Admin.class)
                    .setParameter("email", email)
                    .getSingleResult();
        } catch (NoResultException e) {
            return null; 
        }
    }

    public long countAll(){
        return em.createQuery("SELECT COUNT(a) FROM Admin a", Long.class)
            .getSingleResult();
    }

    public void validerAcces(Long idAdmin){
        Admin a = em.find(Admin.class, idAdmin);
        if (a != null) {
            a.setApprouve(true);
        }
    }

    public void rejeterAcces(Long idAdmin){
        Admin a = em.find(Admin.class, idAdmin);

        if (a != null) {
            em.remove(a);
        }
    }
}