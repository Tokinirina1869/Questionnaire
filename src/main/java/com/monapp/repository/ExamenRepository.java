package com.monapp.repository;

import com.monapp.model.Examen;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.Transactional;
import java.util.List;

@ApplicationScoped
public class ExamenRepository {
    @PersistenceContext
    private EntityManager em;

    @Transactional
    public void save(Examen exam)
    {
        em.persist(exam);
    }

    public List<Examen> findAll()
    {
        return em.createQuery("SELECT e FROM Examen e JOIN FETCH e.etudiant ORDER BY e.note DESC", Examen.class).getResultList();
    }

    public Examen findById(Integer id)
    {
        return em.find(Examen.class, id);
    }
    
    @Transactional
    public void delete(Integer id)
    {
        Examen exam = em.find(Examen.class, id);

        if (exam != null) {
            em.remove(exam);
        }
    }

    public Long countExam()
    {
        Long count = em.createQuery("SELECT COUNT(ex) FROM Examen ex", Long.class).getSingleResult();
        return count;
    }
    public Long countMoinsDe5() {
        return em.createQuery("SELECT COUNT(e) FROM Examen e WHERE e.note < 5", Long.class)
                .getSingleResult();
    }

    public Long countPlusDe5() {
        return em.createQuery("SELECT COUNT(e) FROM Examen e WHERE e.note >= 5", Long.class)
                .getSingleResult();
    }

    public Double getMoyenneGenerale() {
        return em.createQuery("SELECT AVG(e.note) FROM Examen e", Double.class)
                .getSingleResult();
    }

    public Examen findActiveByEtudiant(String numEtudiant) {
        try {
            return em.createQuery(
                "SELECT e FROM Examen e WHERE e.etudiant.numEtudiant = :num AND e.note = 0", 
                Examen.class)
                .setParameter("num", numEtudiant)
                .getSingleResult();
        } catch (Exception e) {
            return null; // Aucun examen en attente trouvé
        }
    }

    @Transactional
    public void update(Examen examen) {
        em.merge(examen); // merge met à jour la ligne existante au lieu d'en créer une nouvelle
    }
}
