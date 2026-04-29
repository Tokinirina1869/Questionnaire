package com.monapp.repository;

import com.monapp.model.Etudiant;
import com.monapp.model.Qcm;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.Transactional;

import java.util.ArrayList;
import java.util.List;

@Stateless
public class QcmRepository {
    
    @PersistenceContext
    private EntityManager em;

    @Transactional
    public void save(Qcm qcm)
    {
        em.persist(qcm);
    }

    public List<Qcm> findAll()
    {
        return em.createQuery("SELECT q FROM Qcm q", Qcm.class).getResultList();
    }

    public List<Qcm> findRandom10() {
        try {
            List<Qcm> results = em.createQuery("SELECT q FROM Qcm q ORDER BY FUNCTION('random')", Qcm.class)
                    .setMaxResults(10)
                    .getResultList();
            System.out.println("REPO DEBUG: Requête exécutée. Taille = " + results.size());
            return results;
        } catch (Exception e) {
            System.err.println("REPO ERROR: Erreur lors de la récupération des QCM");
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    public Qcm findById(Integer id)
    {
        return em.find(Qcm.class, id);
    }

    public Qcm update(Qcm qcm)
    {
        return em.merge(qcm);
    }

    @Transactional
    public void delete(Integer id)
    {
        Qcm qcm = em.find(Qcm.class, id);
        if (qcm != null) {
            em.remove(qcm);
        }
    }

    public Long countQcm()
    {
        Long count = em.createQuery("SELECT COUNT(q) FROM Qcm q", Long.class).getSingleResult();
        return count;
    }
}
