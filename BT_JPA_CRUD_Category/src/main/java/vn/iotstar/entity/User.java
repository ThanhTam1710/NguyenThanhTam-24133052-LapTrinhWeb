package vn.iotstar.entity;

import java.io.Serializable;
import java.sql.Timestamp;
import jakarta.persistence.*;

/**
 * Entity User JPA
 * Sinh viên: Nguyễn Thanh Tâm - MSSV: 24133052
 */
@Entity
@Table(name = "users")
@NamedQueries({
    @NamedQuery(name = "User.findAll", query = "SELECT u FROM User u"),
    @NamedQuery(name = "User.findByUsername", query = "SELECT u FROM User u WHERE u.username = :username"),
    @NamedQuery(name = "User.findByEmail", query = "SELECT u FROM User u WHERE u.email = :email")
})
public class User implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "username", nullable = false, unique = true, length = 100)
    private String username;

    @Column(name = "password", nullable = false, length = 255)
    private String password;

    @Column(name = "email", length = 255)
    private String email;

    @Column(name = "fullname", columnDefinition = "NVARCHAR(255) NULL")
    private String fullname;

    @Column(name = "phone", length = 20)
    private String phone;

    @Column(name = "status")
    private int status = 1; // 0: Chờ kích hoạt, 1: Đã kích hoạt

    @Column(name = "code", length = 20)
    private String code; // Mã OTP

    @Column(name = "otp_expiry")
    private Timestamp otpExpiry;

    public User() {
    }

    public User(String username, String password, String email, String fullname, String phone, int status) {
        this.username = username;
        this.password = password;
        this.email = email;
        this.fullname = fullname;
        this.phone = phone;
        this.status = status;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getFullname() { return fullname; }
    public void setFullname(String fullname) { this.fullname = fullname; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public int getStatus() { return status; }
    public void setStatus(int status) { this.status = status; }

    public String getCode() { return code; }
    public void setCode(String code) { this.code = code; }

    public Timestamp getOtpExpiry() { return otpExpiry; }
    public void setOtpExpiry(Timestamp otpExpiry) { this.otpExpiry = otpExpiry; }
}
