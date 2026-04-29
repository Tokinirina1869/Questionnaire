package com.monapp.service;

import com.monapp.model.Admin;
import com.monapp.repository.AdminRepository;
import jakarta.ejb.Stateless;
import jakarta.inject.Inject;

import java.util.List;

import org.mindrot.jbcrypt.BCrypt;

@Stateless
public class AdminService {

    @Inject
    private AdminRepository repo;

    public List<Admin> listeAdmin(){
        return repo.findAll();
    }

    public void inscrireAdmin(Admin admin) {
        long totalAdmin = repo.countAll();
        
        if (totalAdmin == 0) {
            admin.setApprouve(true); 
        } 
        else {
            admin.setApprouve(false);
        }

        
        String passwordClair = admin.getMdpAdmin();
        String hashed = BCrypt.hashpw(passwordClair, BCrypt.gensalt());
        admin.setMdpAdmin(hashed);

        // 3. Persistance
        repo.save(admin);
    }

    public void approuverAdmin(Long id){
        if (id != null) {
            repo.validerAcces(id);
            System.out.println("Admin " + id + " approuvé avec succès.");
        }
    }

    public void rejeterAdmin(Long id){
        if (id != null) {
            repo.rejeterAcces(id);
            System.out.println("Admin " + id + " approuvé avec succès.");
        }
    }
}