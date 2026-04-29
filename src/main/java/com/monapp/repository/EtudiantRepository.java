package com.monapp.repository;

import com.monapp.model.Admin;
import com.monapp.model.Etudiant;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.transaction.Transactional;
import jakarta.persistence.PersistenceContext;
import java.util.List;

@Stateless
public class EtudiantRepository {
    @PersistenceContext(unitName = "app-questionnairePU")
    private EntityManager em;

    //CREATE = Insert into etudiant ...
    @Transactional
    public void save(Etudiant etu) throws Exception {
        // 1. On vérifie le doublon
        if (findByEmail(etu.getEmail()) != null) {
            throw new Exception("Cette adresse email est déjà utilisée");
        }
        
        em.persist(etu); 
    }
    
    // READ (Unique)
    public Etudiant find(String numEtudiant) 
    {
        return em.find(Etudiant.class, numEtudiant);
    }

    // READ (Tous)
    public List<Etudiant> findAll() 
    {
        return em.createQuery("SELECT e FROM Etudiant e", Etudiant.class).getResultList();
    }

    public Etudiant findByEmail(String email) {
        try {
            return em.createQuery("SELECT e FROM Etudiant e WHERE e.email = :email", Etudiant.class)
                     .setParameter("email", email)
                     .getSingleResult();
        } catch (Exception e) {
            return null; // Si l'email n'existe pas
        }
    }

    // Update
    public Etudiant update(Etudiant e)
    {
        return em.merge(e);  // merge = Mettre à jour en BD
    }

    // Delete
    @Transactional
    public void delete(Etudiant etu) 
    {
        Etudiant e = find(etu.getNumEtudiant());
        if (e != null) {
            em.remove(e);
        }
    }

    public List<Etudiant> search(String query)
    {
        return em.createQuery(
            "SELECT e FROM Etudiant e " +
            "WHERE e.numEtudiant LIKE :q " + 
            "OR e.nom       LIKE :q " +
            "OR e.prenoms   LIKE :q " +
            "OR e.niveau    LIKE :q " +
            "OR e.email     LIKE :q ", 
            Etudiant.class)
            .setParameter("q", "%" + query + "%")
            .getResultList();
    }

    public String generateProchainNum()
    {
        try {
            String jpql = "SELECT MAX(e.numEtudiant) FROM Etudiant e";
            String maxId = (String) em.createQuery(jpql).getSingleResult();

            int nextVal = 1;
            if (maxId != null && maxId.length() >= 4) {
                nextVal = Integer.parseInt(maxId.substring(0, 4)) + 1;
            }

            return String.format("%04d H-F", nextVal);
        } catch (Exception e) {
            return "0001 H-F";
        }
    }

    public Long countEtudiant()
    {
        Long count = em.createQuery("SELECT COUNT(e) FROM Etudiant e", Long.class).getSingleResult();
        
        return count;
    }

    @Transactional
    public void validerAcces(String numEtu){
        Etudiant a = em.find(Etudiant.class, numEtu);
        if (a != null) {
            a.setApprouve(true);
        }
    }

    @Transactional
    public void rejeterAcces(String numEtu){
        Etudiant a = em.find(Etudiant.class, numEtu);

        if (a != null) {
            em.remove(a);
        }
    }
}
